%--------Erwthma 1.3--------
figure(10)
plot(sigma,bestKapa)
hold on 
sig = 0.05:0.01:0.45;
x = sig;
%Kanonas
plot(sig,(3.947678 - 22.80764*x + 243.3986*x.^2 - 1093.89*x.^3 + 2097.516*x.^4 - 1438.689*x.^5))
ylabel('k')
xlabel('sigma')
title('The Rule is a fourth order polynomial')