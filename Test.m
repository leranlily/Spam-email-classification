%function Test
%calculate training and testing error rate of K-nearest Neighbors
function [TRErate, TErate] = Test(Xtrain,Xtest,ytrain,ytest,flag)

[row, col] = size(Xtrain);
Ratio = 0.1;   %ratio of validation set
row1 = floor(row * Ratio);
Xva = Xtrain (1: row1, :);
Xtr = Xtrain (row1 + 1: row, :);
row2 = size (Xtest, 1);

TRerror = zeros (28, 1);
Terror = zeros (28, 1);
TRErate = zeros (28, 1);
TErate = zeros (28, 1);
K = 0;

% repeat as K have 28 different values from 0 to 100
for k = 1: 28
    if k < 11
        K = K + 1;
    else
        K = K + 5;
    end
    
    %using function KNN calculate estimate y in validation set
    for i = 1 : row1
        y = KNN(Xva(i,:), Xtr, ytrain(row1 + 1: row, :), K, flag);
        %count training error
        if (y ~= ytrain(i))
            TRerror(k) = TRerror(k) + 1;
        end
    end
    
    %using function KNN calculate estimate y in testing set
    for i = 1 : row2
        y = KNN(Xtest(i,:), Xtr, ytrain(row1 + 1: row, :), K, flag);
        %count training error
        if (y ~= ytest(i))
            Terror(k) = Terror(k) + 1;
        end
    end
    
    %count training and testing error rates respectively
    TRErate(k) = TRerror(k) / row1;
    TErate(k) = Terror(k) / row2;
end

%plot training and testing error rate versus K
figure;
x = 1 :1 : 10;
plot (x, TRErate(1:10) ,'r-*');
hold on;
plot (x, TErate(1:10) , 'b--o');
hold on;
x = 10 :5 : 100;
plot (x, TRErate(10:28) ,'r-*');
hold on;
plot (x, TErate(10:28) , 'b--o');
hold off;
legend('Training error rate', 'Test error rate');
xlabel('K');
end