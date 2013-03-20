N = 50;

% Switching
th = 10;
u = 50;
g = 0.1;
n = 10;
m = 100;
K = random('logn',log(50),0.1*log(50),N,1);

a  = 1 - m*u + (K.^n)./(K.^n+u.^n);
ts = log(a./(a-g*th))/g;

figure(1); hist(ts)

% Censoring
tc = random('logn',log(10),0.1*log(50),N,1);

% indicator
s = find(ts <= tc);
c = find(tc <  ts);

% plot
figure(2); hold off;
for i = s(:)'
    [T,X] = ode45(@(t,x) 1 - m*u + (K(i)^n)./(K(i)^n+u^n) - g*x,[0,ts(i)],0);
    plot(T,X,'-','color',[0.5,0.5,1]); hold on;
    plot(ts(i),th,'bo');
end


