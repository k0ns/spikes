%Xrhsimopoiw ton kanona gia katametrhsh twn spikes kai gia ta Data_Eval_E_x 
%H sunarthsh epishs briskei to megisto gia ka8e spike kai xrhsimopoiei auto ws
%thn xronikh stimgh pou emfanizetai to spike. Epishs prospa8hsa na kanw antistoixish autwn twn spikes pou
%vriskoume me ayta pou mas dinei gia na vrw poia den antistoixoun sta pragmatika, apla to psaxnw akoma.
%Ekei pou exw to %A) prospa8w na brw to megisto autwn pou mas dinei giati autos tis xronikes stigmes twn
%spikes tis exei pio pisw apo to spike, kai afou vrw to megisto na paw sto %B) kai na dw poia apo auta 
%ta spike pou vrikame exoum to idio megisto. Enas allos tropos pou skeftika einai na 8ewrhsw mono to %B) kai na pw oti osa spike 
%apexoum mia apostash "in_A_Range_Of" apo kapoio diko tou Spike tote einai to idio spike. To poia apo tis duo epiloges
%pou eipa 8a trexei o kwdikas, antikatastiste ekei pou exei (seira 65)
% if nnz((abs(spikeTimes - position(i).spikeTimes(r))) < in_A_Range_Of) == 0 to "spikeTimes" me to "max_spikeTimes" gia na kanei 
%thn sugrish me bash ta megista kai valte to "in_A_Range_Of" iso me 1,dioti leme oti 8a prepei ta megista na einai idia, ektos kai an poume
%oti kai auta apexoun kapoia apostash. Diaforetika etsi opws einai me "spikeTimes" sthn ousia to %A) den xrhsimopoieitai koitaei ta shmeia pou einai konta
%Den to exw domhsei giati kai den 3erw poia me8odos einai kaluterh opote ta trexw mia to ena mia to allo gia na kanw sugriseis gia auto einai ligo mperdemena
close all
minE = zeros(4,1);
range = 30;
for i = 1:1
	name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    sequenceOfNum = 1:1:length(data);   
	std_n = median(abs(data))/0.6745;   
    x = std_n;
    %Kanonas tou K
    bestK = 3.5867 - 10.38108*x + 99.4226*x.^2 - 361.202*x.^3 + 409.5561*x.^4;
    T = bestK*std_n;
    Nspikes = nnz( diff(sequenceOfNum( diff(abs(data)>T) == 1)) > range  );   
    %Diafora apo ton pragmatiko ari8mo twn spikes
	ArxikhDiafora(i) = abs( Nspikes-length(spikeTimes));
    %8a vroume tis xronikes 8eseis twn spikes
    spTimes = sequenceOfNum( diff(abs(data)>T) == 1);
    spikeTimesEst = spTimes(diff(spTimes) > range);
    %Briskoume thn xronikh stigmh tou prwtou akrotatou
        lengthSpike = 40;
        spikeFirstPeakTimes = spikeTimesEst;
        for r = 1:length(spikeFirstPeakTimes)
          [~ , Imax] = max(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+lengthSpike)));
          [~ , Imin] = min(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+lengthSpike)));
          %Pernoume to prwto apo ta duo akrotata
          I = min(Imax,Imin) - lengthSpike - 1;
          spikeFirstPeakTimes(r) = spikeFirstPeakTimes(r) + I;          
        end
    position(i).spikeTimes = spikeFirstPeakTimes;
    %Apo8hkeuoume ta stigmiotupa twn kumatomofwn evrous '2*lengthSpike+1'
    %se enan pinaka ths domhs 'position',ena pinaka gia ka8e arxeio
    position(i).spikeEst = zeros(2*lengthSpike+1,length(spikeFirstPeakTimes));
    for j = 1:length(spikeFirstPeakTimes)
    position(i).spikeEst(:,j) = data((spikeFirstPeakTimes(j)-lengthSpike):(spikeFirstPeakTimes(j)+lengthSpike));
    end
%
    %
%% Ypologismos twn realSpikes kai noiseSpikes
    spikeTimesFirstPeak = spikeTimes;
    %Xronikh stigmh pou exoume to prwto akrotato gia ta dosmena Spikes pou dinontai
    lengthSpike = 60;
    for r = 1:length(spikeTimesFirstPeak)
      [~ , Imax] = max(data(spikeTimesFirstPeak(r):(spikeTimesFirstPeak(r)+lengthSpike)));
      [~ , Imin] = min(data(spikeTimesFirstPeak(r):(spikeTimesFirstPeak(r)+lengthSpike)));
      %Pernoume to prwto apo ta duo akrotata
      I = min(Imax,Imin) - 1;
      spikeTimesFirstPeak(r) = spikeTimesFirstPeak(r) + I;           
    end
   %-----------
    noisePointsIndex = [];
    for r = 1:length(position(i).spikeTimes)
        if nnz((spikeTimesFirstPeak == position(i).spikeTimes(r))) == 0
        noisePointsIndex = [noisePointsIndex r];
        end
    end
    noisePointTimes = position(i).spikeTimes(noisePointsIndex);
    RealSpikesTimes = position(i).spikeTimes;
    RealSpikesTimes(noisePointsIndex) = [];
    
    nuOfnoisePoints(i) = length(noisePointTimes);
    %
    %Noise Spikes
    figure(3)
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
    
    %
    %Pragmatika Spikes
    figure(4)
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
TelikhDiafora = ArxikhDiafora + nuOfnoisePoints
%Pososto epituxias
success = (TelikhDiafora./numOfSpikes).*100

%{
%Plot twn spikes pou dinei h ekfwnhsh me to dianusma spikeTimes
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
%Plot twn spikes pou vrikame apo ton kanona
figure(2)
for g = 1:length(position(i).spikeTimes)
plot((data(position(i).spikeTimes(g)-25:position(i).spikeTimes(g)+25)))
hold on 
plot(26,data(position(i).spikeTimes(g)),'r*')
name = ['Spike' num2str(g)];
title(name);
pause(0.000000001);
%hold off
end
%}

%{
%Plot twn spikes pou vrikame alla apo ton pinaka spikeEst, 
%einai to idio me to apo panw apla autos to 8elei se pinaka kai apla to ekana na uparxei
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

