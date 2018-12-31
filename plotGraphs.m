
%% -------- Erwthma 1.1 --------
close all
figureNum = 0;
%
mkdir('plots/1.1');
for i = 1:8
	name = ['Data/Data_Test_' num2str(i)];
	load(name)
    handler = figure(figureNum+1);
    figureNum = figureNum+1;
    plot(data(1:10000))
    name_title = sprintf('DataTest%d',i);
    title(name_title,'FontSize',15)
    loc = sprintf('plots/1.1/%s',name_title);
    saveFigureFullSize(handler,loc) 
end

%% -------- Erwthma 1.2 --------
mkdir('plots/1.2');
findBestK;
%Grafikh K vs Sigma
handler = figure(figureNum+1);
figureNum = figureNum+1;
plot(sigma,bestKapa)
ylabel('K')
xlabel('sigma')
title('����������� � ���������� ��� ����������� ��� �������','FontSize',15)
name_title = sprintf('K_Vs_Sigma');
loc = sprintf('plots/1.2/%s',name_title);
saveFigureFullSize(handler,loc)  
%
%% -------- Erwthma 1.3 --------
mkdir('plots/1.3');
handler = figure(figureNum+1);
figureNum = figureNum+1;
plot(sigma,bestKapa)
hold on 
%Kanonas
sig = 0.05:0.01:0.45;
x = sig;
plot(sig,(2.973 + 26.08*x + -332.6*x.^2 + 1556*x.^3 + -3289*x.^4 + 2624*x.^5))
ylabel('�')
xlabel('sigma')
title('� ������� ����� ��������� 5�� ������')
name_title = sprintf('Kanonas');
loc = sprintf('plots/1.3/%s',name_title);
saveFigureFullSize(handler,loc);   

%Epalh8evoume oti o kanonas doulevei swsta
%Xrhsimopoioume ton kanona sta DataTest dedomana gia epalh8eush
TestDataCountSpikes;

f = figure(figureNum+1);
figureNum = figureNum+1;
Data = [Nspikes,givenNumSpikes,minE];
colNames = {'������������','��������','�������'};
rowNames = {'DataTest1','DataTest2','DataTest3','DataTest4','DataTest5','DataTest6','DataTest7','DataTest8'};
uitable(f,'RowName',rowNames,'ColumnName',colNames,'Data',Data,'Position',[10 220 330 180]);
name_title = sprintf('NumOfSpikesByTheRule');
loc = sprintf('plots/1.3/%s',name_title);
saveas(figureNum,loc,'png')   
%

%% -------- Erwthma 2.1 --------
mkdir('plots/2.1');
%Xrhsimopoioume ton kanona sta DataEval dedomena
%EvalDataCountSpikes;

f = figure(figureNum+1);
figureNum = figureNum+1;
Data = [Nspikes,givenNumSpikes,ArxikhDiafora];
colNames = {'������������','��������','�������'};
rowNames = {'DataEval1','DataEval2','DataEval3','DataEval4'};
uitable(f,'RowName',rowNames,'ColumnName',colNames,'Data',Data,'Position',[10 220 330 100]);
name_title = sprintf('NumOfSpikesByTheRule');
loc = sprintf('plots/2.1/%s',name_title);
saveas(figureNum,loc,'png')   

%% -------- Erwthma 2.2 --------
mkdir('plots/2.2');
%Plot twn spikes pou vrikame apo ton kanona
for i = 1:4
    handler = figure(figureNum+1);
    figureNum = figureNum+1;
    for g = 1:length(savedData(i).spikeEst)
    plot( savedData(i).spikeEst(:,g))
    hold on 
    plot(lengthSpike+1,savedData(i).spikeEst(lengthSpike+1,g),'r*')
    title('Spikes ordered by the first Peak');
    name_title = sprintf('SpikesByFirstPeak');
    loc = sprintf('plots/2.2/%s',name_title);
    saveFigureFullSize(handler,loc)   
    end
end

%% -------- Erwthma 2.3 --------
mkdir('plots/2.3');
%Ypologismos 8oruvou sta Spikes kai antistoixhsh twn spikes se classes
noiseSpikes;
%Pososto epituxias telika
successEnd = 100 - (abs(TelikhDiafora)./numOfGivenSpikes).*100;
%Pososto 8oruvou sta deigmata
Noise = ((numOfNoiseSpikes)./(numOfrealSpikes+numOfNoiseSpikes)).*100;

f = figure(figureNum+1);
figureNum = figureNum+1;
Data = [numOfNoiseSpikes + numOfrealSpikes,numOfrealSpikes,numOfNoiseSpikes,Noise,successEnd];
colNames = {'������� ������� Spikes','���� ��� ���������������','������� �������','������� �������','������ ������� ���������'};
rowNames = {'DataEval1','DataEval2','DataEval3','DataEval4'};
uit = uitable(f,'RowName',rowNames,'ColumnName',colNames,'Data',Data,'Position',[10 20 755 100]);
name_title = sprintf('NumOfSpikesByTheRule');
loc = sprintf('plots/2.3/%s',name_title);
saveas(figureNum,loc,'png')   
%}
%% -------- Erwthma 2.4 --------
mkdir('plots/2.4')
calfeatures;
plotFeatures;
%
%% -------- Erwthma 2.5 --------
mkdir('plots/2.5')
rateClassification;
bestCombinations =  OrderedRate(1:5,:);



