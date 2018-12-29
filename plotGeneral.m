%{
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

plot(sig,(3.947678 - 22.80764*x + 243.3986*x.^2 - 1093.89*x.^3 + 2097.516*x.^4 - 1438.689*x.^5))
ylabel('k')
xlabel('sigma')
%}

%{
close all
i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for i = 1:1500
m = spikeTimes(i);
d = 30;
plot((data(m-d:m+d+40)))
hold on
plot(d+1,data(m),'r*')
end
%}

%{
close all
i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for i = 1:500
m = spikeTimes(i);
d = 30;
plot((data(m-d:m+d+40)))
hold on
plot(d+1,data(m),'r*')
end
%}


%{
Plot classes
i = 4;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for class = 1:3
    figure(10+class)
    T = savedData(i).spikeFirstPeakTimes(savedData(i).classEst == class) ;
    for j = 1:length(T)/20
        m = T(j) ;
        d = 30;
        plot(data(m-d:m+d+40))
        hold on
        plot(d+1,data(m),'r*')
    end
    title(['Spike class ' num2str(class)])
end 
%}


%{Plot classes
close all
i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for class = 1:3
    figure(10+class)
    T = spikeTimes(spikeClass == class);
    for i = 1:length(T)/40
        m = T(i) ;
        d = 30;
        plot((data(m-d:m+d+40)))
        hold on
        re = 22;
        plot(d+re+1,data(m+re),'r*')
    end
    title(['Spike class ' num2str(class)])
end 
%}

%{
Plot twn spikes pou vrikame apo ton kanona
figure(4)
i = 1;
for g = 1:length(savedData(i).spikeEst)/20
plot( savedData(i).spikeEst(:,g))
hold on 
plot(2*lengthSpike+1,savedData(i).spikeEst(2*lengthSpike+1,g),'r*')
name = ['Spike' num2str(g)];
title(name);
%pause(1);
%hold off
end
%}

