%--------Erwthma 1.3--------
figure(10)
plot(sigma,bestKapa)
hold on 
sig = 0.05:0.01:0.45;
x = sig;
%Kanonas
plot(sig,(2.973 + 26.08*x + -332.6*x.^2 + 1556*x.^3 + -3289*x.^4 + 2624*x.^5))
ylabel('k')
xlabel('sigma')
title('The Rule is a fifth order polynomial')