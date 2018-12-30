close all
ArxikhDiafora = zeros(4,1);
for i = 1:4
%-----Erwthma 2.1-----
    name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    numOfSpikes(i) = length(spikeTimes);
    sequenceOfNum = 1:1:length(data);
	std_n = median(abs(data))/0.6745;   
    x = std_n;
    %Kanonas tou K
    bestK = 2.973 + 26.08*x + -332.6*x.^2 + 1556*x.^3 + -3289*x.^4 + 2624*x.^5;
    T = bestK*std_n;
    %Ari8mos twn Spikes
    Nspikes = nnz(diff(data>T) == 1);   
    %Diafora apo ton pragmatiko ari8mo twn spikes
	ArxikhDiafora(i) = Nspikes-length(spikeTimes);
    %8a vroume tis xronikes 8eseis/stigmes twn spikes,stis opoies mia exmh pernaei
    %to katwfli 'T'
    spikeTimesEst = sequenceOfNum( diff(data>T) == 1) + 1;
    %Apo8hkeuoume tis xronikes stigmes se mia domh 
    savedData(i).spikeTimesEst = spikeTimesEst;
 
%-----Erwthma 2.2-----
    %Briskoume thn xronikh stigmh tou prwtou akrotatou
        lengthSpike = 11;
        spikeFirstPeakTimes = spikeTimesEst;
            for r = 1:length(spikeFirstPeakTimes);
              if spikeFirstPeakTimes(r)-lengthSpike > 0 && spikeFirstPeakTimes(r)+lengthSpike <= length(data);
                  mesosOros = mean(data((spikeFirstPeakTimes(r)-3*lengthSpike):(spikeFirstPeakTimes(r)+3*lengthSpike)));
                  [~ , Imax] = max(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+lengthSpike)));
                  [minValue , Imin] = min(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+lengthSpike)));
                  if  minValue > -3*abs(mesosOros) 
                      [~ , Imin] = min(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+3*lengthSpike)));
                  end
                  %Pernoume to prwto apo ta duo akrotata
                  I = min(Imax,Imin) - lengthSpike - 1;
                  spikeFirstPeakTimes(r) = spikeFirstPeakTimes(r) + I;  
              end
            end
       
    %Apo8hkeuoume tis xronikes stigmes se mia domh gia to plot argotera 
    savedData(i).spikeFirstPeakTimes = spikeFirstPeakTimes;
    %Apo8hkeuoume ta stigmiotupa twn kumatomofwn evrous '3*lengthSpike+1'
    savedData(i).spikeEst = zeros(4*lengthSpike+1,length(spikeFirstPeakTimes));
    for j = 1:length(spikeFirstPeakTimes)
    savedData(i).spikeEst(:,j) = data((spikeFirstPeakTimes(j)-2*lengthSpike):(spikeFirstPeakTimes(j)+2*lengthSpike));
    end
 %-----------------------------------------

end

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
Plot twn spikes pou vrikame apo ton kanona
figure(2)
for g = 1:length(savedData(i).spikeFirstPeakTimes)
d = 40;    
plot((data(savedData(i).spikeFirstPeakTimes(g)-d+16:savedData(i).spikeFirstPeakTimes(g)+d+4)))
hold on 
plot(d-15,data(savedData(i).spikeFirstPeakTimes(g)),'r*')
name = ['Spike' num2str(g)];
title(name);
pause(0.5);
%hold off
end
%}

%{
Plot twn spikes pou vrikame apo ton kanona
figure(3)
for g = 1:length(savedData(i).spikeEst)
plot( savedData(i).spikeEst(:,g))
hold on 
plot(lengthSpike+1,savedData(i).spikeEst(lengthSpike+1,g),'r*')
name = ['Spike' num2str(g)];
title(name);
%pause(1);
%hold off
end
%}
