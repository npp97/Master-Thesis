function A = LLL_reduction(A,delta)
% LLL lattice reduction
% Matlab implementation by K. Shum
% The input A is a square matrix. Columns of input A are the basis vectors 
% The output A is a square matrix, whose columns are LLL-redcued basis
% vectors

if nargin == 1
    delta = .75; % the default value of the parameter delta
end

m = length(A); % the dimension of the vector space
B = zeros(m,m); % Columns of B are the vectors after the Gram-Schmidt process
mu = zeros(m,m); % The matrix mu stores the GS coefficients
M = zeros(1,m); % M(i) is the norm squared of the i-th column of B

% Gram-Schmidt orthogonalization
B(:,1) = A(:,1); % Set the first column of B as the same
 % as the first column of A
M(1) = dot(B(:,1), B(:,1));
for i = 2:m
    mu(i,1:(i-1)) = (A(:,i)'* B(:,1:(i-1))) ./ M(1:(i-1));
    B(:,i) = A(:,i) - B(:,1:(i-1))*mu(i,1:(i-1))';
    M(i) = dot(B(:,i), B(:,i));
end

k = 2;
while k <= m

    % Size reduction
   for i = (k-1):-1:1
        q = round(mu(k,i));
        if q ~=0
            A(:,k) = A(:,k) - q*A(:,i);  % size-reduce the k-th basis vector
            mu(k,1:i) =  mu(k,1:i) - q*[mu(i,1:(i-1)) 1]; % update the GS coefficients
   end
 end

    % Check the Lovasz condition
    if dot(B(:,k),B(:,k)) >= (delta - abs(mu(k,k-1))^2)* dot(B(:,(k-1)),B(:,(k-1)))
        k = k+1; % increment k if the Lovasz condition holds
    else
        % If the Lovasz condition fails,
 % swap the k-th and (k-1)-st basis vector
        v = A(:,k); A(:,k) = A(:,k-1); A(:,k-1) = v;

        % update the Gram-Schmidt coefficients
        for s = (k-1):k
            mu(s,1:(s-1)) = (A(:,s)'* B(:,1:(s-1))) ./ M(1:(s-1));
            B(:,s) = A(:,s) - B(:,1:(s-1))*mu(s,1:(s-1))';
            M(s) = dot(B(:,s), B(:,s));
        end
        mu((k+1):m,(k-1):k) = (A(:,(k+1):m)'* B(:,(k-1):k)) / diag(M((k-1):k));

        if k > 2
            k = k-1;
        end
 end
end