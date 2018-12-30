close all
numOfNoiseSpikes = zeros(4,1);
numOfrealSpikes = zeros(4,1);
numOfGivenSpikes = zeros(4,1);
%% Ypologismos twn realSpikes kai noiseSpikes
%-----Erwthma 2.3-----
for i = 1:4
    name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    numOfGivenSpikes(i) = length(spikeTimes);    
    maxRange = 30;
    sm = 15;    noisePointsIndex = [];
    savedData(i).classEst = zeros(size(savedData(i).spikeTimesEst,2),1);
    for r = 1:size(savedData(i).spikeFirstPeakTimes,2)
        minDictance = savedData(i).spikeFirstPeakTimes(r) - spikeTimes;
        minDictance(minDictance < 0) = maxRange + 1000; %aporiptoume arnhtikes times
        [minDictance ,index] = min(minDictance);
        if minDictance > maxRange || minDictance < sm
            noisePointsIndex = [noisePointsIndex r];
        else
            savedData(i).classEst(r) = spikeClass(index);
            
            %{
%Pragmatika Spikes
            figure(3)
            g = index;
            e = 83;
            m = savedData(i).spikeFirstPeakTimes(r);
            subplot(1,2,2)
            plot((data(m-e:m+e)))
            hold on 
            plot(e+1,data(m),'r*')
            hold off
            subplot(1,2,1)
            m = spikeTimes(index);
            subplot(1,2,1)
            plot((data(m-e:m+e+30)))
            hold on 
            plot(e+1,data(m),'r*')
            hold off
            pause(1.5)
            name = ['Spike' num2str(g)];
            title(name);
            pause(0.0001);
            %hold off
            %}
        end
    end
    noisePointTimes = savedData(i).spikeFirstPeakTimes(noisePointsIndex);
    RealSpikesTimes = savedData(i).spikeFirstPeakTimes;
    RealSpikesTimes(noisePointsIndex) = [];
    numOfNoiseSpikes(i) = length(noisePointTimes);
    numOfrealSpikes(i) = length(RealSpikesTimes);
    %{
%Noise Spikes
    figure(1)
    for g = 1:length(noisePointTimes)
    plot( (data(noisePointTimes(g)-32:noisePointTimes(g)+70)))
    hold on 
    plot(33,data(noisePointTimes(g)),'r*')
    name = ['Spike' num2str(g)];
    title(name);
    pause(0.2);
    %hold off
    end
    %}
    
    %{   
 %Pragmatika Spikes
    figure(2)
    for g = 1:length(RealSpikesTimes)
    plot( (data(RealSpikesTimes(g)-32:RealSpikesTimes(g)+32)))
    hold on 
    plot(33,data(RealSpikesTimes(g)),'r*')
    name = ['Spike' num2str(g)];
    title(name);
    pause(0.0001);
    %hold off
    end
    %}
    
    
end

%Arxikh Diafora apotelesmatwn
ArxikhDiafora
%Meta thn eka8arhsh twn noise point
TelikhDiafora = numOfrealSpikes - numOfGivenSpikes

%Pososto epituxia arxika
successBegin = 100 - (abs(ArxikhDiafora)./numOfGivenSpikes).*100

%Pososto epituxias telika
successEnd = 100 - (abs(TelikhDiafora)./numOfGivenSpikes).*100

%Pososto 8oruvou sta deigmata
Noise = ((numOfNoiseSpikes)./(numOfrealSpikes+numOfNoiseSpikes)).*100

