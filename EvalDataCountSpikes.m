close all
ArxikhDiafora = zeros(4,1);
range = 30; %Aixmes pou einai konta anoikoun sto idio spike  
for i = 1:4
%-----Erwthma 2.1-----
    name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    numOfSpikes(i) = length(spikeTimes);
    sequenceOfNum = 1:1:length(data);
	std_n = median(abs(data))/0.6745;   
    x = std_n;
    %Kanonas tou K
    bestK = 3.5867 - 10.38108*x + 99.4226*x.^2 - 361.202*x.^3 + 409.5561*x.^4;
    T = bestK*std_n;
    %Ari8mos twn Spikes
    Nspikes = nnz( diff(sequenceOfNum( diff(abs(data)>T) == 1)) > range  );   
    %Diafora apo ton pragmatiko ari8mo twn spikes
	ArxikhDiafora(i) = abs( Nspikes-length(spikeTimes));
    %8a vroume tis xronikes 8eseis/stigmes twn spikes,stis opoies mia exmh pernaei
    %to katwfli 'T' kai apexei toulaxinston apostash 'range' apo mia allh exmh
    spikeTimesEst = sequenceOfNum( diff(abs(data)>T) == 1);
    spikeTimesEst = spikeTimesEst(diff(spikeTimesEst) > range);
    %Apo8hkeuoume tis xronikes stigmes se mia domh 
    position(i).spikeTimesEst = spikeTimesEst;
 
%-----Erwthma 2.2-----
    %Briskoume thn xronikh stigmh tou prwtou akrotatou
        lengthSpike = 33;
        spikeFirstPeakTimes = spikeTimesEst;
        for ep = 1:3
            for r = 1:length(spikeFirstPeakTimes)
              [~ , Imax] = max(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+lengthSpike)));
              [~ , Imin] = min(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+lengthSpike)));
              %Pernoume to prwto apo ta duo akrotata
              I = min(Imax,Imin) - lengthSpike - 1;
              spikeFirstPeakTimes(r) = spikeFirstPeakTimes(r) + I;          
            end
        end
    %Apo8hkeuoume tis xronikes stigmes se mia domh gia to plot argotera 
    position(i).spikeFirstPeakTimes = spikeFirstPeakTimes;
    %Apo8hkeuoume ta stigmiotupa twn kumatomofwn evrous '2*lengthSpike+1'
    position(i).spikeEst = zeros(2*lengthSpike+1,length(spikeFirstPeakTimes));
    for j = 1:length(spikeFirstPeakTimes)
    position(i).spikeEst(:,j) = data((spikeFirstPeakTimes(j)-lengthSpike):(spikeFirstPeakTimes(j)+lengthSpike));
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
for g = 1:length(position(i).spikeTimes)
d = 40;    
plot((data(position(i).spikeTimes(g)-d+16:position(i).spikeTimes(g)+d+4)))
hold on 
plot(d-15,data(position(i).spikeTimes(g)),'r*')
name = ['Spike' num2str(g)];
title(name);
pause(0.000000001);
%hold off
end
%}

%{
Plot twn spikes pou vrikame apo ton kanona
figure(3)
for g = 1:length(position(i).spikeEst)
plot( position(i).spikeEst(:,g))
hold on 
plot(lengthSpike+1,position(i).spikeEst(lengthSpike+1,g),'r*')
name = ['Spike' num2str(g)];
title(name);
%pause(1);
%hold off
end
%}

