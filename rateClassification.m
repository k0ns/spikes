%-----Erwthma 2.5----
rate = zeros(4,1);
for i = 1:4
    %Epilogh xarakthristikwn
    Data = [savedData(i).features(:,1) savedData(i).features(:,7)];
    group = savedData(i).classEst;
    rate(i) = MyClassify(Data, group);
end
rate