close all
numOfnoisePoints = zeros(4,1);
numOfSpikes = zeros(4,1);
%% Ypologismos twn realSpikes kai noiseSpikes
%-----Erwthma 2.3-----
for i = 1:4
    name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    numOfSpikes(i) = length(spikeTimes);    
    givenSpikesFirstPeak = spikeTimes;
    %Xronikh stigmh pou exoume to prwto akrotato gia ta Spikes pou dinontai
    lengthSpike = 64;
    for r = 1:length(givenSpikesFirstPeak)
      [~ , Imax] = max(data(givenSpikesFirstPeak(r):(givenSpikesFirstPeak(r)+lengthSpike)));
      [~ , Imin] = min(data(givenSpikesFirstPeak(r):(givenSpikesFirstPeak(r)+lengthSpike)));
      %Pernoume to prwto apo ta duo akrotata
      I = min(Imax,Imin) - 1;
      givenSpikesFirstPeak(r) = givenSpikesFirstPeak(r) + I;           
    end
    %Ta dosmena Spikes ka8os kai auta pou exoun vre8ei apo ton kanona exoun
    %antistoixh8ei ws pros to prwto akrota tous,opote sthn sunexeia kanoume
    %ena pros ena antistoixhsei gia na vroume poia einai pragmatika Spikes 
    noisePointsIndex = [];
    for r = 1:length(position(i).spikeFirstPeakTimes)
        if nnz((givenSpikesFirstPeak == position(i).spikeFirstPeakTimes(r))) == 0
        noisePointsIndex = [noisePointsIndex r];
        end
    end
    noisePointTimes = position(i).spikeFirstPeakTimes(noisePointsIndex);
    RealSpikesTimes = position(i).spikeFirstPeakTimes;
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

