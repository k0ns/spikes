%% Evresh twn idanikwn K ths Sxeshs T=K*ón kai plot korufwn vs K
%------Erwthma 1.2------
close all
minE = zeros(8,1);
bestKPosition = zeros(8,1);
bestKapa =  zeros(8,1);
sigma =  zeros(8,1);
best_T =  zeros(8,1);
nValues = 200; 
min_k = 2;
max_k = 4;
for i = 1:8
	name = ['Data/Data_Test_' num2str(i)];
	load(name)
    sequenceOfTimes = 1:1:length(data);  
	std_n = median(abs(data))/0.6745;
    stepK = (max_k-min_k)/nValues;
	Nspikes = zeros(nValues,1);
    
    j = 1;
	for k = min_k:stepK:max_k
    	T = k*std_n;  
        %Ta 8etika spikes
    	Nspikes(j) = nnz( diff(data>T) == 1);
        j = j+1;
	end
    
	[minE(i),bestKPosition(i)] = min(abs(Nspikes - spikeNum));
    k = min_k:stepK:max_k;
    bestKapa(i) = k(bestKPosition(i));
    sigma(i) = std_n;
    best_T(i) = k(bestKPosition(i))*std_n;
 	%Sxediash k vs Spikes
    figure(i)
 	plot(k,Nspikes)
    hold on 
    plot(k,ones(length(k),1)*spikeNum)
    plot(k(bestKPosition(i)),spikeNum,'r*')
 	xlabel('k')
 	ylabel('Number of Spikes')
    
end
%Elaxisth diafora
minE
%Grafikh k vs Sigma
figure(9)
plot(sigma,bestKapa)
ylabel('k')
xlabel('sigma')
title('K vs Sigma')
%}

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