%-------Erwthma 1.3 epivevaiwsh kanona------
minE = zeros(8,1);
range = 30;
for i =1:8
	name = ['Data/Data_Test_' num2str(i)];
	load(name)    
	std_n = median(abs(data))/0.6745;
    sequenceOfTimes = 1:1:length(data);
    %Kanonas gia ta K
    x = std_n;
    bestK = 3.5867 - 10.38108*x + 99.4226*x.^2 - 361.202*x.^3 + 409.5561*x.^4;
    T = bestK*std_n;
    %Nspikes = nnz( diff(abs(data)>T) == 1 );
    Nspikes = nnz( diff(sequenceOfTimes( diff(abs(data)>T) == 1)) > range  );
    
	minE(i) = abs( Nspikes-spikeNum);
    
end
%Diafora apotelesmatwn
minE