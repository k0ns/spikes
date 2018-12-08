%{
H seira ektelesei ton arxeiwn einai 
1)numSpikesFun.m
2)plotRules.m
3)countSpikes.m
4)countEvalSpikes.
%}

%Einai h prwth synarthsh pou trexoume kai ftiaxnei tis grafikes Ari8mosSpikes sunarthsh K
%gia na broume veltisto K. Epish sto telos ftiaxnei kai thn grafikh K-sigma pou 8ewrw oti 
%mesw auths 8a broume to kanona gia to K, dhladh o kanonas 8a e3artatai apo to sigma pou
%dinei to poso 8oruvou ths kumato morfhs. Meta kalw thn 'plotRule.m' gia na sxediash ton kanona.
close all
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
 	%
    figure(i)
 	plot(k,Nspikes)
    hold on 
    plot(k,ones(length(k),1)*spikeNum)
    plot(k(bestK(i)),spikeNum,'r*')
 	xlabel('k')
 	ylabel('Number of Spikes')
   %}
    
end
minE
%
figure(18)
plot(sigma,bestKapa)
ylabel('k')
xlabel('sigma')
%}