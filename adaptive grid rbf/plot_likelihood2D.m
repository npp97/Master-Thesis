function plot_likelihood2D( P )
%PLOT_LIKELIHOOD Summary of this function goes here
%   Detailed explanation goes here

figure(4)
clf

xx = linspace(P.paramspec{1}{3},P.paramspec{1}{4},100);
yy = linspace(P.paramspec{2}{3},P.paramspec{2}{4},100);

[XX,YY] = meshgrid(xx,yy);

X = [XX(:),YY(:)];
textprogressbar('Progress: ');
F=zeros(size(X,1),1);
for j = 1 : size(X,1)
    if(mod(j,100)==0)
        textprogressbar(j/100^2/10000)
    end
    [F(j)] = eval_llh(X(j,:),P);
end
textprogressbar('done');

surf(XX,YY,reshape(F,size(XX)))
xlim([P.paramspec{1}{3},P.paramspec{1}{4}]);
ylim([P.paramspec{2}{3},P.paramspec{2}{4}]);
view(0,90)
shading interp
xlabel(['log(' P.paramspec{1}{1} ')']);
ylabel(['log(' P.paramspec{2}{1} ')']);

colorbar

end