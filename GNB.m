%function GNB
%calculate training and testing error rate of Gaussian naive Bayes classifier
function [TRErate, TErate] = GNB(Xtrain,Xtest,ytrain,ytest)

[row, col] = size(Xtrain);
count0 = 0;
count1 = 0;
Xtr0 = zeros(row, col);
Xtr1 = zeros(row, col);
y = zeros(row, 1);
h = 0;
k = 0;

%divide features in to two matrix according to value of y
for i = 1 : row
    if ytrain(i) == 0        
        h = h + 1;
        Xtr0(h, :) = Xtrain(i, :);
    else
        k = k + 1;
        Xtr1(k, :) = Xtrain(i, :);
    end
end

Xtr0 = Xtr0(1 : h, 1 : col);
Xtr1 = Xtr1(1 : k, 1 : col);

%calculate each mean and variance
sum0 = zeros (h, 1);
ave0 = zeros (h, 1);
var0 = zeros (h, 1);
sum1 = zeros (k, 1);
ave1 = zeros (k, 1);
var1 = zeros (k, 1);

for i = 1 : col
    for j = 1 : h
        sum0(i) = sum0(i) + Xtr0(j, i);
    end
    
    ave0(i) = sum0(i) / h;
    
    for j = 1 : h
    var0(i)= var0(i) + ( Xtr0(j, i) - ave0(i)) ^ 2;
    end
   
    var0(i) = var0(i) / h;
    
    for j = 1 : k
        sum1(i) = sum1(i) + Xtr1(j, i);
    end
    
    ave1(i) = sum1(i) / k;
    
    for j = 1 : k
    var1(i)= var1(i) + ( Xtr1(j, i) - ave1(i)) ^ 2;
    end
   
    var1(i) = var1(i) / k;
end

%count the number of the value of y
for i = 1: row
    if ytrain(i) == 0
        count0 = count0 + 1;
    elseif ytrain(i) == 1;
       count1 = count1 + 1;
    end
end

%calculate prior using ML
py0 = count0 / row;
py1 = count1 / row;

NTRerror = 0;
NTerror = 0;

%calculate posterior predictive distribution for Gaussian
%test of training set
for i = 1 : row
    pt0 = py0;
    pt1 = py1;
    
    %calculate the probalility according to prior and posterior
    for j = 1 : col
         pt0 = pt0 * exp( -(( Xtrain(i, j)-ave0(j))^ 2 /var0(j)) / 2) / 2.5/sqrt(var0(j));
         pt1 = pt1 * exp( -(( Xtrain(i, j)-ave1(j))^ 2 /var1(j)) / 2) / 2.5/sqrt(var1(j));
    end
    
    %compare the estimate y with the correct y
    if pt0 > pt1
        y(i) = 0;
    else
        y(i) = 1;
    end
    
    %count training error
    if y(i) ~= ytrain(i);
        NTRerror = NTRerror + 1;
    end
end


% test of testing set
row2 = size (Xtest, 1);
y1 = zeros(row2, 1);

for i = 1 : row2
    pt0 = py0;
    pt1 = py1;
    
    %calculate the probalility according to prior and posterior
    for j = 1 : col
         pt0 = pt0 * exp( -(( Xtest(i, j)-ave0(j))^ 2 /var0(j)) / 2) / 2.5/sqrt(var0(j));
         pt1 = pt1 * exp( -(( Xtest(i, j)-ave1(j))^ 2 /var1(j)) / 2) / 2.5/sqrt(var1(j));
    end
    
    %compare the estimate y with the correct y
    if pt0 > pt1
        y1(i) = 0;
    else
        y1(i) = 1;
    end
    
    %count testing error
    if y1(i) ~= ytest(i);
        NTerror = NTerror + 1;
    end
end

%count training and testing error rates respectively
TRErate = NTRerror / row;
TErate = NTerror / row2;
end