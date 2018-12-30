%-----Erwthma 2.5----
rate = zeros(4,1);
for i = 1:4
    %Epilogh xarakthristikwn
    Data = [savedData(i).features(:,4) savedData(i).features(:,7) savedData(i).features(:,9)];
    group = savedData(i).classEst;
    rate(i) = MyClassify(Data, group);
end
rate