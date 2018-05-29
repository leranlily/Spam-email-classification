clear;
clc;

load('spamData.mat');
[row, col] = size(Xtrain);
count0 = 0;
count1 = 0;
count_0 = zeros (col, 2);
count_1 = zeros (col, 2);

%data processing, use function binarization
Xpro =  binarization(Xtrain); 

%count the number of the value of y
%count the number of the value of each feature
for i = 1: row
    if ytrain(i) == 0
        count0 = count0 + 1;
        for j = 1 : col
            if Xpro(i, j) == 0
                count_0(j, 1) = count_0(j, 1) + 1;
            else
                count_0(j, 2) = count_0(j, 2) + 1;
            end
        end
    elseif ytrain(i) == 1;
       count1 = count1+ 1;
       for j = 1 : col
            if Xpro(i, j) == 0
                count_1(j, 1) = count_1(j, 1) + 1;
            else
                count_1(j, 2) = count_1(j, 2) + 1;
            end
        end 
    end
end

%calculate prior using ML
py0 = count0 / row;
py1 = count1 / row;

row2 = size (Xtest, 1);
y = zeros(row, 1);
y2 = zeros(row2, 1);
alpha = 0;
TRErate = zeros (201,1);
TErate = zeros (201,1);

%data processing
Xtpro =  binarization(Xtest);

% repeat as alpha have 201 different values from 0 to 100
for k = 1 :201
    NTRerror = 0;
    NTerror = 0;
    p_0 = zeros (col, 2);
    p_1 = zeros (col, 2);

%calculate posterior predictive distribution for beta-bernoulli   
for i = 1 : col
    p_0(i, 1) = (count_0(i, 1) + alpha) / ((alpha * 2) + count0);
    p_0(i, 2) = (count_0(i, 2) + alpha) / ((alpha * 2) + count0);
    p_1(i, 1) = (count_1(i, 1) + alpha) / ((alpha * 2) + count1);
    p_1(i, 2) = (count_1(i, 2) + alpha) / ((alpha * 2) + count1);
end

    alpha = alpha + 0.5;

% test of training set
for i = 1 : row
    ptr0 = py0;
    ptr1 = py1;
    
    %calculate the probalility according to prior and posterior
    for j = 1 : col
        if Xpro(i, j) == 0
            ptr0 = ptr0 * p_0(j, 1);
            ptr1 = ptr1 * p_1(j, 1);
        else
            ptr0 = ptr0 * p_0(j, 2);    
            ptr1 = ptr1 * p_1(j, 2);   
        end
    end
    
    %compare the estimate y with the correct y
    if ptr0 > ptr1
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
for i = 1 : row2
    pt0 = py0;
    pt1 = py1;
   
    %calculate the probalility according to prior and posterior
    for j = 1 : col
        if Xtpro(i, j) == 0
            pt0 = pt0 * p_0(j, 1);
            pt1 = pt1 * p_1(j, 1);
        else
            pt0 = pt0 * p_0(j, 2);    
            pt1 = pt1 * p_1(j, 2);   
        end
    end
    
    %compare the estimate y with the correct y
    if pt0 > pt1
        y2(i) = 0;
    else
        y2(i) = 1;
    end
    
    %count testing error
    if y2(i) ~= ytest(i);
        NTerror = NTerror + 1;
    end
end

%count training and testing error rates respectively
TRErate(k) = NTRerror / row;
TErate(k) = NTerror / row2;
end

%plot training and testing error rate versus alpha
figure(1);
x = 0 :0.5 : 100;
plot (x, TRErate ,'r-*');
hold on;
plot (x, TErate , 'b--o');
hold off;
legend('Training error rate', 'Test error rate');
xlabel('alpha');