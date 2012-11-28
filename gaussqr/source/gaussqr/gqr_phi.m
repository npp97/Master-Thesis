function p = gqr_phi(Marr,x,ep,alpha,deriv)
% This function evaluates the Gaussian eigenfunctions
% They are uniquely defined given an epsilon, and alpha
% You can choose which indices you want evaluated
% You can also evaluate derivatives of these eigenfunctions
%
% Example: To evaluate the y derivative of the 
%          [1,1] and [1,2] eigenfunctions within 0<1<x, 2<y<3
%     x = pick2Dpoints([0,2],[1,3],5);
%     GQR.ep = .1;
%     GQR.alpha = 1;
%     GQR.Marr = [[1;1],[1;2]];
%     deriv = [0,1];
%     phi_y = gqr_phi(GQR,x,deriv);
%
% function p = gqr_phi(GQR,x)
% This is the preferred way of calling the phi function
% Inputs : GQR - The GaussQR object created by gqr_solveprep
%                This should contain at least the members
%                GQR.Marr - row array of multiindices
%                GQR.ep - Gaussian shape parameter
%                GQR.alpha - GaussQR global scale parameter
%          x - The location to evaluate the eigenfunctions at
% Outputs : p - The eigenfunction values
%
% function p = gqr_phi(GQR,x,deriv)
% This is used to evaluate derivatives of the eigenfunctions
% Inputs : deriv - array of derivative values
% Outputs : p - The eigenfunction derivative values
%
% function p = gqr_phi(Marr,x,ep,alpha)
% The same idea as before, but now without the GQR object
% Inputs : Marr - row array of multiindices
%          ep - Gaussian shape parameter
%          alpha - GaussQR global scale parameter
%          x - The location to evaluate the eigenfunctions at
% Outputs : p - The eigenfunction values
%
% function p = gqr_phi(Marr,x,ep,alpha,deriv)
% The same idea as before, but now without the GQR object
% Inputs : deriv - array of derivative values
% Outputs : p - The eigenfunction derivative values
%
% Note: if you pass alpha<0 or ep<0 or m<1, this will error out
%
% Derivatives are calculated using the relationship:
%    d/dx(p_{n}(x)) = -2*delta2*x*p_{n}(x)+sqrt(2n-2)*beta*alpha*p_{n-1}(x)
%
% Note: minimum M value is 1, in accordance with new structure
%       anything less than 1 will return 0

global GAUSSQR_PARAMETERS
if ~isstruct(GAUSSQR_PARAMETERS)
    error('GAUSSQR_PARAMETERS does not exist ... did you forget to call rbfsetup?')
end
asympttol = GAUSSQR_PARAMETERS.RBFPHI_EXP_TOL;
fastphi = GAUSSQR_PARAMETERS.FAST_PHI_EVALUATION;

switch nargin
    case {2,3}
        if nargin==3
            deriv = ep;
        end
        GQR = Marr;
        if not(all(isfield(GQR,{'Marr','ep','alpha'})))
            error('GQR object must have fields Marr, ep, alpha')
        else
            Marr = GQR.Marr;
            ep = GQR.ep;
            alpha = GQR.alpha;
        end
    case {4,5}
    otherwise
        error('nargin=%d unacceptable')
end

% Here we define: n as the number of data points
%                 s as the dimension of the data
[Mr Mc] = size(Marr);
[n xc] = size(x);
if Mr~=xc
    error(sprintf('dimension mismatch: size(Marr,1)=%d, size(x,2)=%d',Mr,xc))
else
    s=xc;
end

if not(exist('deriv'))
    deriv = zeros(1,s); % Default to no derivatives being used
else
    [dr dc] = size(deriv);
    if dc~=s
        error('dimension mismatch: size(x,2)=%d, size(deriv,2)=%d',s,dc)
    elseif min(deriv)<0
        error('negative derivative requested, %d',min(deriv))
    elseif dr~=1
        error('d must be a row vector of derivatives')
    end
    if sum(deriv<0 + deriv>4)>0 % Right now you only have 4 derivatives
        warning('%d is an unacceptable derivative, reset to 0',deriv)
        deriv = zeros(1,s);
    end
end

if abs(real(alpha))~=alpha || abs(real(ep))~=ep
    error('alpha=%g or ep=%g unacceptable; must be real and positive',alpha,ep)
end

beta = (1+(2*ep/alpha)^2)^(1/4);
if beta-1<asympttol % This triggers an asymptotic expansion
    delta2 = ep^2-ep^4/alpha^2+2*ep^6/alpha^4;
else
    delta2 = 1/2*alpha^2*(beta^2-1);
end

% Consider fast evaluation, and perform it if the problem
%   - activates the flag in rbfsetup
%   - is in 1D
%   - has no derivatives
%   - has Marr=1:Mc
if fastphi
    if xc>1
        warning('Fast phi eval unavailable for higher dimensions, using slow eval')
        fastphi = 0;
    elseif deriv>0
        warning('Fast phi eval unavailable for derivatives, using slow eval')
        fastphi = 0;
    elseif size(Marr,2)<3 | Mc~=Marr(end)
        fastphi = 0; % Just pass it on to rbfphi_EVAL
    elseif any(Marr~=1:Mc)
        fastphi = 0; % Indices are out of order
    else
        p = gqr_phi_FASTEVAL_PRIVATE(Marr,x,ep,alpha,beta,delta2);
    end
end

% Use traditional evaluation of eigenfunctions, either because fast
% evaluation was declined, or because the if block above said fast
% evaluation was unavailable
if not(fastphi)
    p = zeros(n,Mc);
    sx2 = sum(x.^2,2);
    for k=1:Mc
        if min(Marr(:,k))>=1 % Since H_{-1}=0 by definition
            p(:,k) = gqr_phi_EVAL_PRIVATE(Marr(:,k),x,ep,alpha,deriv,beta,delta2,sx2);
        end
    end
end
end






% This below is the private function which actually does the evaluation of
% the eigenfunctions.  You should not ever directly call this from outside
% of this file.
%
% This function only accepts one multiindex at a time, although I'm sure
% there's a better way to do it.
%
% Derivatives:
%  1 : -2*delta2*xk.*pm+sqrt(2*m-2)*beta*alpha*pm1
%  2 : 2*delta2*(2*delta2*xk.^2-1).*pm + ...
%      -4*sqrt(2)*delta2*beta*alpha*sqrt(m-1)*xk.*pm1 + ...
%      2*(beta*alpha)^2*sqrt((m-1)*(m-2))*pm2;
%  3 : 4*delta2^2*xk.*(3-2*delta2*xk.^2).*pm + ...
%      6*sqrt(2)*delta2*beta*alpha*sqrt(m-1)*(2*delta2*xk.^2-1).*pm1 + ...
%      -12*delta2*(beta*alpha)^2*sqrt((m-1)*(m-2))*xk.*pm2 + ...
%      2*sqrt(2)*(beta*alpha)^3*sqrt((m-1)*(m-2)*(m-3))*pm3
%  4 : 4*delta2^2*(4*delta2^2*xk.^4-12*delta2*xk.^2+3).*pm + ...
%      -16*sqrt(2)*delta2^2*beta*alpha*sqrt(m-1)*xk.*(2*delta2*xk.^2-3).*pm1 + ...
%      24*delta2*(beta*alpha)^2*sqrt((m-1)*(m-2))*(2*delta2*xk.^2-1).*pm2 + ...
%      -16*sqrt(2)*delta2*(beta*alpha)^3*sqrt((m-1)*(m-2)*(m-3))*xk.*pm3 + ...
%      4*(beta*alpha)^4*sqrt((m-1)*(m-2)*(m-3)*(m-4))*pm4
%
% Recurrence Relations:
%  2 : phi_{n-2}(x) = 1/sqrt(m-2) *
%                     (sqrt(2)*beta*alpha*xk .*phi_{n-1}(x) - 
%                      sqrt(m-1)*phi_n(x))
%  3 : phi_{n-3}(x) = 1/(sqrt(m-2)*sqrt(m-3)) *
%                     ((2*(beta*alpha)^2*xk.^2-(n-1)+1) .*phi_{n-1}(x) -
%                      sqrt(2)*sqrt(m-1)*beta*alpha*xk*phi_n(x))
%  4 : phi_{n-4}(x) = 1/(sqrt(m-2)*sqrt(m-3)*(m-4)) *
%                     (sqrt(2)*beta*alpha*xk.*(2*(beta*alpha)^2*xk.^2-2*(m-1)+1) .*phi_{n-1}(x) - 
%                      sqrt(m-1)*(2*(beta*alpha)^2*x.^2-(n-1)+2).*phi_n(x)
%
% The actual derivatives below are computed with a recursion to allow for
% fewer computations of phi
function p = gqr_phi_EVAL_PRIVATE(Marr,x,ep,a,deriv,b,d2,sx2)
global GAUSSQR_PARAMETERS
if ~isstruct(GAUSSQR_PARAMETERS)
    error('GAUSSQR_PARAMETERS does not exist ... did you forget to call rbfsetup?')
end
logoption = GAUSSQR_PARAMETERS.RBFPHI_WITH_LOGS;

[n s] = size(x);
ba = b*a;
s2 = sqrt(2);

if sum(deriv)==0 % No derivatives, easier to handle
    q = -.5*(sum(Marr-1)*log(2)+sum(gammaln(Marr))-s*log(b))-d2*sx2;
    [Hx,Hi] = HermiteProd(Marr-1,ba*x,logoption);
    if logoption
        p = exp(q+Hx).*(-1).^Hi;
    else
        p = exp(q).*Hx;
    end
else
    if logoption
        Ni = zeros(n,1);
        p = zeros(n,1);
    else
        p = ones(n,1);
    end
    for k=1:s
        m = Marr(k);
        sm1 = sqrt(m-1);
        xk = x(:,k);
        pm = gqr_phi_EVAL_PRIVATE(m,xk,ep,a,0,b,d2,sx2);
        if m>1
            pm1 = gqr_phi_EVAL_PRIVATE(m-1,xk,ep,a,0,b,d2,sx2);
        end
        switch deriv(k) % Check which derivative is being asked for
            case 0
                pv = pm;
            case 1
                if m==1
                    pv = -2*d2*xk.*pm;
                else
                    pv = -2*d2*xk.*pm+s2*sm1*ba*pm1;
                end
            case 2
                switch m
                    case 1
                        pv = 2*d2*(2*d2*xk.^2-1).*pm;
                    case 2
                        pv = 2*d2*(2*d2*xk.^2-1).*pm + ...
                             -4*s2*d2*ba*sm1*xk.*pm1;
                    otherwise
                        pv = (2*d2*(2*d2*xk.^2-1)-2*ba^2*(m-1)).*pm + ...
                            (ba^2-2*d2)*2*s2*ba*sm1*xk.*pm1;
                end
            case 3
                switch m
                    case 1
                        pv = 4*d2^2*xk.*(3-2*d2*xk.^2).*pm;
                    case 2
                        pv = 4*d2^2*xk.*(3-2*d2*xk.^2).*pm + ...
                             6*s2*d2*ba*sm1*(2*d2*xk.^2-1).*pm1;
                    case 3
                        pv = -4*d2*xk.*(2*d2^2*x.^2-3*d2-3*ba^2*(m-1)).*pm + ...
                             -6*s2*sm1*d2*ba*(2*xk.^2*ba^2+1-2*d2*xk.^2).*pm1;
                    otherwise
                        pv = (-8*d2^3*xk.^3+(12*d2*ba^2*(m-1)+12*d2^2-4*ba^4*(m-1))*xk).*pm + ...
                             (4*s2*ba*sm1*(3*d2^2+ba^4-3*ba^2*d2)*xk.^2-2*s2*ba*sm1*(ba^2*(m-2)+3*d2)).*pm1;
                end
            case 4
                switch m
                    case 1
                        pv = 4*d2^2*(4*d2^2*xk.^4-12*d2*xk.^2+3).*pm;
                    case 2
                        pv = 4*d2^2*(4*d2^2*xk.^4-12*d2*xk.^2+3).*pm + ...
                             -16*s2*d2^2*ba*sm1*xk.*(2*d2*xk.^2-3).*pm1;
                    case 3
                        pv = 4*d2*(4*d2^3*xk.^4-12*d2*(d2+ba^2*(m-1))*xk.^2+3*(d2+2*ba^2*(m-1))).*pm + ...
                             8*s2*sm1*d2*ba*xk.*(2*d2*(3*ba^2-2*d2)*xk.^2+3*(2*d2-ba^2)).*pm1;
                    case 4
                        pv = 4*d2*(4*d2^3*xk.^4-4*(3*d2^2+3*(m-1)*ba^2*d2-2*ba^4*(m-1))*xk.^2+3*(d2+2*ba^2*(m-1))).*pm + ...
                             -8*s2*sm1*d2*ba*(2*(2*ba^4+2*d2^2-3*d2*ba^2)*xk.^3+(-6*d2+5*ba^2-2*ba^2*(m-1))*xk).*pm1;
                    otherwise
                        pv = 4*(4*d2^4*xk.^4+2*(4*d2*ba^4*(m-1)-6*d2^2*ba^2*(m-1)-ba^6*(m-1)-6*d2^3)*xk.^2+ba^4*(m-3)*(m-1)+3*d2^2+6*d2*ba^2*(m-1)).*pm + ...
                             4*s2*sm1*ba*xk.*(2*(ba^6-4*d2*ba^4+6*d2^2*ba^2-4*d2^3)*xk.^2+4*d2*ba^2*(m-1)+12*d2^2-2*ba^4*(m-1)+3*ba^4-10*d2*ba^2).*pm1;
                end
            otherwise
                error('Unacceptable derivative %d in rbfphi_EVAL, somehow',d)
        end
        if logoption
            Ni = Ni + (pv<0);
            warning off MATLAB:log:logOfZero
            p = p + log(abs(pv));
            warning on MATLAB:log:logOfZero
        else
            p = p.*pv;
        end
    end
    if logoption
        p = exp(p).*(-1).^Ni;
    end
end
end

% This below is the private function which actually does the evaluation of
% the eigenfunctions.  You should not ever directly call this from outside
% of this file.
%
% This exploits the recurrence relation
%   phi_{n+1} = sqrt(2/n)*beta*alpha*x*phi_n - sqrt((n-1)/n)*phi_{n-1}
% to compute all the columns of the phi matrix using only direct
% computation of the first two columns.
%
% This method only works right now for 1D and no derivatives, although the
% derivatives can be added without too much difficulty.
%
% Also, this assumes that Marr is ordered 1:M.  Technically I guess this
% doesn't have to be true, but for practical circumstances it would
% be, so I'm not sure that I need to consider anything else.  I'll think
% about it - maybe you'd want only the even powers for something ...
%
% The error properties of this approach are still not know, and need to be
% considered eventually.
function p = gqr_phi_FASTEVAL_PRIVATE(Marr,x,ep,alpha,beta,delta2)

M = size(Marr,2);
N = size(x,1);
p = zeros(N,M);
sx2 = sum(x.^2,2); % For passing to rbfphi_EVAL

p(:,1) = gqr_phi_EVAL_PRIVATE(1,x,ep,alpha,0,beta,delta2,sx2);
p(:,2) = gqr_phi_EVAL_PRIVATE(2,x,ep,alpha,0,beta,delta2,sx2);

for k=2:M-1
    p(:,k+1) = (sqrt(2/k)*beta*alpha)*(x.*p(:,k)) - sqrt((k-1)/k)*p(:,k-1);
end

end

% For Developers only
% Note: serious improvments may be possible using a recurrence relation -
%       it will generally be the case that we are interested in computing
%       all the eigenfucntions phi_m for 1<m<M, in which case we could
%       exploit the relationship:
%   p_{n+1}(x)=sqrt(2/n)*beta*alpha*x*p_{n}(x)-sqrt(1-1/n)*p_{n-1}(x)
%       Doing so would require us to catch the fact that the user has asked
%       for a sequence of values, and it would also potentially undermine
%       the log thing, since we'd end up computing alot of the values via
%       the recurrence.  The ideal setting would be to compute some values
%       directly and others via the recurrence to balance the savings in
%       cost with the gains from vectorization.
%
%       Of course, along that same thought this whole code could actually
%       probably be improved by computing more than one column of this
%       matrix at a time.  Given that, the dominant cost is still the QR
%       factorization, but it might not always be that way.
%
%       Derivatives could potentially be handled combinatorially to allow
%       for more efficient computation, but that would be really hard.  The
%       advantage would be that each term in the summations that represent
%       the derivatives could be handled with logs.
%       Also for derivatives, when we switch to the asymptotic Hermite's
%       there may be a safer way to compute the derivative.  Since the
%       Hermite's have an asymptotic form, that could be differentiated
%       directly rather than using the recurrence relation.
%
%       More work should be done to determine the error ramifications of
%       computing derivatives directly (d+1 function evals for d
%       derivatives) versus using recurrence relation
%
%       If logoption is activated, there should be only one step away from
%       the log setting - right at the end.  Everything else should be
%       handled in the log domain.  Right now, 0th derivative terms are
%       computed in the log domain, exponentiated, and then logged again to
%       bring them together in the derivative formulas.  I should make a
%       way to keep the pieces separate and bring them together later.
%
%       Maybe the way to go is to create a function that computes the
%       coefficients for any order derivative in the recurrence form and
%       call that each time it is needed.  Then the eigenfunction and the
%       coefficient computation are separated.
%
%       For derivatives, there's potential of a log of 0, which isn't real,
%       because it will go away when it get's applied to the other
%       dimensions.  I need to consider that.
