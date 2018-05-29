%function LR
%calculate training and testing error rate of Logistic regression
function [TRErate,TErate] = LR(Xtrain,Xtest,ytrain,ytest)

[row, col] = size(Xtrain);
row2 = size (Xtest, 1);

TRerror = zeros (28, 1);
Terror = zeros (28, 1);
TRErate = zeros (28, 1);
TErate = zeros (28, 1);
lambda = 0;
X0 = ones(row, 1);
Xpro = [Xtrain, X0];
s = zeros (row, 1);
mu = zeros (row, 1);
X1 = ones(row2, 1);
Xpro1 = [Xtest, X1];

% repeat as lambda have 28 different values from 0 to 100
for k = 1 : 28
    if k < 11
        lambda = lambda + 1;
    else
        lambda = lambda + 5;
    end
    
    w = zeros(col + 1, 1);

    %use Newton's Method
    %evaluate mu, g, H
    for i = 1 : row
        mu(i) = 1/(1 + exp ( - Xpro(i,:) * w));
    end 
    
    g = Xpro' * (mu - ytrain);
    I = diag(ones(col + 1,1),0);
    I( 1 : col,:) = I( 1 : col,:) * lambda;
    I(col + 1) = 0;
    for i = 1 : row 
        s(i) = mu(i)*(1 - mu(i));
    end
    
    S = diag(s,0);
    H =Xpro' * S * Xpro + I;
    
    %repeat until convergence
    while ((H \ g)'*(H \ g))>0.000000001
        w = w - H \ g;
        
        for i = 1 : row
            mu(i) = 1/(1 + exp ( - Xpro(i,:) * w));
        end 
        for i = 1 : row 
            s(i) = mu(i)*(1 - mu(i));
        end
    
        S = diag(s,0);
        w1 = w;
        w1( 1 : col) = w( 1 : col) *   lambda;
        w1(col+1) = 0;
        g = Xpro' * (mu - ytrain) + w1;
        H =Xpro' * S * Xpro + I;
    end

    %calculate the probalility
    %count training error
    for i = 1 : row 
        p = w' * Xpro(i, :)';
        if p > 0;
            if ytrain(i) ~= 1
                TRerror(k) = TRerror(k) + 1;
            end
        else
            if ytrain(i) ~= 0
                TRerror(k) = TRerror(k) + 1;
            end
        end
    end   

    %calculate the probalility
    %count testing error
    for i = 1 : row2
        p = w' * Xpro1(i, :)';
        if p > 0;
            if ytest(i) ~= 1
                Terror(k) = Terror(k) + 1;
            end
        else
            if ytest(i) ~= 0
                Terror(k) = Terror(k) + 1;
            end
        end
    end   
    
    %count training and testing error rates respectively
    TRErate(k) = TRerror(k) / row;
    TErate(k) = Terror(k) / row2;
end

%plot training and testing error rate versus lambda
figure;
x = 1 :1 : 10;
plot (x, TRErate(1:10) ,'r-*');
hold on;
plot (x, TErate(1:10) ,'b--o');
hold on;
x = 10 :5 : 100;
plot (x, TRErate(10:28) ,'r-*');
hold on;
plot (x, TErate(10:28) ,'b--o');
hold off;
legend('Training error rate', 'Test error rate');
xlabel('lambda');
end