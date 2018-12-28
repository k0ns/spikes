close all
numOfnoisePoints = zeros(4,1);
numOfSpikes = zeros(4,1);
%% Ypologismos twn realSpikes kai noiseSpikes
%-----Erwthma 2.3-----
for i = 1:4
    name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    numOfSpikes(i) = length(spikeTimes);    
    givenSpikesFirstPeakTimes = spikeTimes;
    %Xronikh stigmh pou exoume to prwto akrotato gia ta Spikes pou dinontai
    stepForward = 58;
    for r = 1:length(givenSpikesFirstPeakTimes)
      [~ , Imax] = max(data(givenSpikesFirstPeakTimes(r):(givenSpikesFirstPeakTimes(r)+stepForward)));
      [~ , Imin] = min(data(givenSpikesFirstPeakTimes(r):(givenSpikesFirstPeakTimes(r)+stepForward)));
      %Pernoume to prwto apo ta duo akrotata
      I = min(Imax,Imin) - 1;
      givenSpikesFirstPeakTimes(r) = givenSpikesFirstPeakTimes(r) + I;           
    end
    %Ta dosmena Spikes ka8os kai auta pou exoun vre8ei apo ton kanona exoun
    %antistoixh8ei ws pros to prwto akrota tous,opote sthn sunexeia kanoume
    %ena pros ena antistoixhsei gia na vroume poia einai pragmatika Spikes 
    noisePointsIndex = [];
    sequenceOfNum = 1:1:size(spikeClass,2);
    savedData(i).classEst = zeros(size(savedData(i).spikeTimesEst,2),1);
    for r = 1:size(savedData(i).spikeFirstPeakTimes,2)
        tempBoolean = givenSpikesFirstPeakTimes == savedData(i).spikeFirstPeakTimes(r);
        if nnz(tempBoolean) == 0
            noisePointsIndex = [noisePointsIndex r];
        else
            [~,index] = max(tempBoolean);
            savedData(i).classEst(r) = spikeClass(sequenceOfNum(index));
        end
    end
    noisePointTimes = savedData(i).spikeFirstPeakTimes(noisePointsIndex);
    RealSpikesTimes = savedData(i).spikeFirstPeakTimes;
    RealSpikesTimes(noisePointsIndex) = [];
    numOfnoisePoints(i) = length(noisePointTimes);
  
    %{
    Noise Spikes
    figure(1)
    for g = 1:length(noisePointTimes)
    plot( (data(noisePointTimes(g)-32:noisePointTimes(g)+32)))
    hold on 
    plot(33,data(noisePointTimes(g)),'r*')
    name = ['Spike' num2str(g)];
    title(name);
    pause(0.0001);
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
TelikhDiafora = ArxikhDiafora + numOfnoisePoints
%Pososto epituxias
success = 100 - (TelikhDiafora./numOfSpikes).*100
