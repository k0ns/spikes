%{
figure(10)
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
%plot(sig,( + *x + *x.^2 + *x.^3 + *x.^4 + *x.^5))

%plot(sig,(3.947678 - 22.80764*x + 243.3986*x.^2 - 1093.89*x.^3 + 2097.516*x.^4 - 1438.689*x.^5))
%plot(sig,(3.631 + 3.43*x + -70.1*x.^2 + 219.6*x.^3 + -210.7*x.^4))
plot(sig,( 2.973 + 26.08*x + -332.6*x.^2 + 1556*x.^3 + -3289*x.^4 + 2624*x.^5))
ylabel('k')
xlabel('sigma')
%}

%{
Plot twn pragmatikwn spikes
figure(1)
for g = 1:length(spikeTimes)
plot((data(spikeTimes(g)-50:spikeTimes(g)+50)))
hold on
plot(51,data(spikeTimes(g)),'r*')
name = ['Spike' num2str(g)];
title(name);
pause(0.1);
%hold off
end
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
pause(0.5)
%hold off
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
Plot classes with timeEst thn sttigmh pou pernane to katoflh
i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for class = 1:3
    figure(10+class)
    T = savedData(i).spikeTimesEst(savedData(i).classEst == class) ;
    for j = 1:length(T)
        m = T(j) ;
        d = 30;
        plot(data(m-d:m+d+40))
        hold on
        plot(d+1,data(m),'r*')
        %pause(1);
        %hold off
    end
    title(['Spike class ' num2str(class)])
end 
%}



%{
Plot classes with spikeFirstPeakTimes to prwtoAkrotato
i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for class = 1:3
    figure(10+class)
    T = savedData(i).spikeFirstPeakTimes(savedData(i).classEst == class) ;
    T2 = savedData(i).spikeTimesEst(savedData(i).classEst == class) ;
    for j = 1:length(T)
        m = T(j) ;
        d = 30;
        plot(data(m-d:m+d+40))
        hold on
        plot(d+1,data(m),'r*')
        %plot(d+1+ T2(j) - m,data(T2(j)),'b*')
        %pause(1);
        %hold off
    end
    title(['Spike class ' num2str(class)])
end 
%}

%{
Plot classes
close all
i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for class = 1:1
    figure(10+class)
    T = spikeTimes(spikeClass == class);
    Ms = zeros(length(T)/10,1);
    MiN = Ms;
    for i = 1:length(T)/10
        m = T(i) ;
        d = 60;
        Ms(i)=mean(data(m-33:m+33));
        MiN(i) = min(data(m-33:m+33));
        plot((data(m-d:m+d+40)))
        hold on
        re = 0;
        plot(d+re+1,data(m+re),'r*')
        %pause(0.5)
    end
    title(['Spike class ' num2str(class)])
    
end 
%}

%{
Plot twn spikes pou vrikame apo ton kanona
figure(4)
i = 1;
for g = 1:length(savedData(i).spikeEst)
plot( savedData(i).spikeEst(:,g))
hold on 
plot(2*lengthSpike+1,savedData(i).spikeEst(2*lengthSpike+1,g),'r*')
name = ['Spike' num2str(g)];
title(name);
pause(0.001);
%hold off
end
%}

%{
close all
i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
spikeTimes = spikeTimes(1:300);
data = data(1:spikeTimes(end));
plot(data)
for g = 1:length(spikeTimes)
hold on 
plot(spikeTimes(g),data(spikeTimes(g)),'r*')
name = ['Spike' num2str(g)];
title(name);
%pause(1);
%hold off
end
%}

%{
j = 4;
num = 0;
table = savedData(j).spikeFirstPeakTimes;
i = 1;
while(i<length(table))
    w = nnz(table == table(i));
    if(w>1)
        
        num = num+1;
        %table(table == table(i)) = [];
        %i = i-1;
    end
 i = i+1;   
end
num
%}