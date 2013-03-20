M = [0 1
     1 0
     0 2
     1 1
     2 0
     0 3
     1 2
     2 1
     3 0];
I = [4 0];

b = zeros(size(M,1),1);
A = zeros(size(M,1));
for i1 = 1:size(M,1)
    for i2 = 1:size(M,1)
        b(i1)    = nchoosek_vec(I,M(i1,:));
        A(i1,i2) = nchoosek_vec(M(i2,:),M(i1,:));
    end
end
A\b

        