function out = testfunction1(x)
% TESTKERNEL1
%Builds a piecewise function in 3 pieces: a small left portion which
%satisfies boundary conditions through beta=6, a small right portion which
%satisfies boundary conditions through beta=6, and a middle portion which 
%has a discontinuity in the 0th derivative/in the funtion itself.


y = .01; %where the middle insufficiently smooth portion begins. Note the 
%difference between .01 and .1 -- to check later?
eps = 1;

out = zeros(length(x),1);
for i = 1:length(x)
    if (0 <= x(i) )&& (x(i) < y)
        out(i) = x(i).*x(i).^25.*(x(i)-1).^25;
    elseif ((1 >= x(i)) && (x(i) >= 1-y))
        out(i) =  x(i).*x(i).^25.*(x(i)-1).^25;
    elseif ((x(i) <= 1-y) && (x(i)>=y))
        out(i) = x(i).^3;
    else
        error('An x value is not in the range (0,1)');
    end
end
