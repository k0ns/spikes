%% Erwtima 1.1
close all
for i = 1:8
	name = ['Data/Data_Test_' num2str(i)];
	load(name)
    figure(i)
    plot(data(1:10000))
    name_title = sprintf('DataTest%d',i);
    title(name_title,'FontSize',33)
    loc = sprintf('plots/1.1/%s',name_title)
    saveas(i,loc,'png')
    close all
end

%% Erwtima 2.2
minE = zeros(8,1);
bestK = zeros(8,1);
bestKapa =  zeros(8,1);
sigma =  zeros(8,1);
best_T =  zeros(8,1);
nValues = 100; 
min_k = 2;
max_k = 5;
range = 30; %Aixmes pou  einai konta anoikoun sto idio spike  
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
        %Ta 8etika spikes kai arnhtika spikes pou omws apexoun apostash 'range', dioti diaforetika anoikoun sto idio Spike
    	Nspikes(j) = nnz( diff(sequenceOfTimes( diff(abs(data)>T) == 1)) > range  );
        j = j+1;
	end
    
	[minE(i),bestK(i)] = min(abs(Nspikes - spikeNum));
    k = min_k:stepK:max_k;
    bestKapa(i) = k(bestK(i));
    sigma(i) = std_n;
    best_T(i) = k(bestK(i))*std_n;

    
    figure(i)
 	plot(k,Nspikes,'LineWidth',3)
    hold on 
    plot(k,ones(length(k),1)*spikeNum,'LineWidth',2)
    plot(k(bestK(i)),spikeNum,'r*','LineWidth',5)
 	xlabel('k','FontSize',30,'FontWeight','bold')
 	ylabel('Number of Spikes','FontSize',30,'FontWeight','bold')
    name_title = sprintf('DataTest%d',i);
    title(name_title,'FontSize',33,'FontWeight','bold')
    loc = sprintf('plots/1.2/%s',name_title);
    saveas(i,loc,'png')
    close all
end 
    
    
    