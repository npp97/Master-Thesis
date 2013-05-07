function r=ksr(x,y,h,N)
% KSR   Kernel smoothing regression
%
% r=ksr(x,y) returns the Gaussian kernel regression in structure r such that
%   r.f(r.x) = y(x) + e
% The bandwidth and number of samples are also stored in r.h and r.n
% respectively.
%
% r=ksr(x,y,h) performs the regression using the specified bandwidth, h.
%
% r=ksr(x,y,h,n) calculates the regression in n points (default n=100).
%
% Without output, ksr(x,y) or ksr(x,y,h) will display the regression plot.
%
% Algorithm
% The kernel regression is a non-parametric approach to estimate the
% conditional expectation of a random variable:
%
% E(Y|X) = f(X)
%
% where f is a non-parametric function. Based on the kernel density
% estimation, this code implements the Nadaraya-Watson kernel regression
% using the Gaussian kernel as follows:
%
% f(x) = sum(kerf((x-X)/h).*Y)/sum(kerf((x-X)/h))
%
% See also gkde, ksdensity

% Example 1: smooth curve with noise
%{
x = 1:100;
y = sin(x/10)+(x/50).^2;
yn = y + 0.2*randn(1,100);
r=ksr(x,yn);
plot(x,y,'b-',x,yn,'co',r.x,r.f,'r--','linewidth',2)
legend('true','data','regression','location','northwest');
title('Gaussian kernel regression')
%}
% Example 2: with missing data
%{
x = sort(rand(1,100)*99)+1;
y = sin(x/10)+(x/50).^2;
y(round(rand(1,20)*100)) = NaN;
yn = y + 0.2*randn(1,100);
r=ksr(x,yn);
plot(x,y,'b-',x,yn,'co',r.x,r.f,'r--','linewidth',2)
legend('true','data','regression','location','northwest');
title('Gaussian kernel regression with 20% missing data')
%}

% By Yi Cao at Cranfield University on 12 March 2008.
%

% Check input and output
error(nargchk(2,4,nargin));
error(nargoutchk(0,1,nargout));
if numel(x)~=numel(y)
    error('x and y are in different sizes.');
end

x=x(:);
y=y(:);
% clean missing or invalid data points
inv=(x~=x)|(y~=y);
x(inv)=[];
y(inv)=[];

% Default parameters
if nargin<4
    N=100;
elseif ~isscalar(N)
    error('N must be a scalar.')
end
r.n=length(x);
if nargin<3
    % optimal bandwidth suggested by Bowman and Azzalini (1997) p.31
    hx=median(abs(x-median(x)))/0.6745*(4/3/r.n)^0.2;
    hy=median(abs(y-median(y)))/0.6745*(4/3/r.n)^0.2;
    h=sqrt(hy*hx);
    if h<sqrt(eps)*N
        error('There is no enough variation in the data. Regression is meaningless.')
    end
elseif ~isscalar(h)
    error('h must be a scalar.')
end
r.h=h;

% Gaussian kernel function
kerf=@(z)exp(-z.*z/2)/sqrt(2*pi);

r.x=linspace(min(x),max(x),N);
r.f=zeros(1,N);
g=zeros(length(x));

for l=1:length(x)
    z=kerf((x(l)-x)/h);
    g(l)=sum(z.*y)/sum(z);
    s(l)=(y(l)-g(l))^2;
end

s = s';

for k=1:N
    z=kerf((r.x(k)-x)/h);
    r.f(k)=sum(z.*y)/sum(z);
    r.s(k)=sum(z.*s)/sum(z);
%     % bootstrap
%     for l=1:20
%         ii = randi(length(x),[length(x)/1000,1]);
%         zz=kerf((r.x(k)-x(ii))/h);
%         n(k,l) = sum(zz.*y(ii))/sum(zz);
%     end
    

end
% r.m=mean(n');
% r.s=var(n');

% Plot
if ~nargout
    plot(r.x,r.f,'r',x,y,'bo')
    ylabel('f(x)')
    xlabel('x')
    title('Kernel Smoothing Regression');
end
