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
    sm = 14;    
    noisePointsIndex = [];
    savedData(i).classEst = zeros(size(savedData(i).spikeTimesEst,2),1);
    for r = 1:size(savedData(i).spikeFirstPeakTimes,2)
        minDictance = savedData(i).spikeFirstPeakTimes(r) - spikeTimes;
        minDictance(minDictance < 0) = maxRange + 1000; %aporiptoume arnhtikes times
        [minDictance ,index] = min(minDictance);
        if minDictance > maxRange || minDictance < sm
            noisePointsIndex = [noisePointsIndex r];
        else
            savedData(i).classEst(r) = spikeClass(index);
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
    %pause(0.5);
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
