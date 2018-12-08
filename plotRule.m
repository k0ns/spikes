%Meta thn ekteleshs tou 'numSpikesFun.m' kalw auto to script gia na sxediash ena prosegistiko kanona
%Meta 8a kalesw to 'countSpikes.m'
plot(sigma,bestKapa)
hold on 
sig = 0.05:0.01:0.45;
%plot(sig,(exp(-9*(sig-0.12))+2.39))
%plot(sig,(15*exp(-16*(sig-0.05))+ 2.8))
%plot(sig,(2.976219 - 9.131413*x + 83.55689*x.^2 - 270.4655*x.^3 + 281.2435*x.^4))
%plot(sig,(2.789526 - 0.3823291*x + 32.56158*x.^2 - 163.4297*x.^3 + 206.8395*x.^4))
%plot(sig,(3.5867 - 10.38108*x + 99.4226*x.^2 - 361.202*x.^3 + 409.5561*x.^4))
%plot(sig,(2.938489 - 2.075351*x + 44.91508*x.^2 - 201.3227*x.^3 + 245.2394*x.^4))
x = sig;

plot(sig,(3.947678 - 22.80764*x + 243.3986*x.^2 - 1093.89*x.^3 + 2097.516*x.^4 - 1438.689*x.^5)) %<-----Kanonas
ylabel('k')
xlabel('sigma')
%}

%{
close all
for i = 1:300
m = spikeTimes(i+50);
d = 10;
plot(abs(data(m-d:m+d+40)))
hold on
plot(d+1,data(m),'r*')
end
%}


%{
Taf = bestKapa(i)*std_n*ones(length(data),1);
s = 1000:12000;
plot((data(s)))
hold on
plot(Taf(s))
%}