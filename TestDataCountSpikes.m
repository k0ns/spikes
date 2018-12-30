%-------Erwthma 1.3 epivevaiwsh kanona------
minE = zeros(8,1);
for i =1:8
	name = ['Data/Data_Test_' num2str(i)];
	load(name)    
	std_n = median(abs(data))/0.6745;
    sequenceOfTimes = 1:1:length(data);
    %Kanonas gia ta K
    x = std_n;
    bestK = 2.973 + 26.08*x + -332.6*x.^2 + 1556*x.^3 + -3289*x.^4 + 2624*x.^5
    T = bestK*std_n;
    %Nspikes = nnz( diff(abs(data)>T) == 1 );
    Nspikes = nnz( diff(data>T) == 1) ;
    
	minE(i) = abs( Nspikes-spikeNum);
    
end
%Diafora apotelesmatwn
minE