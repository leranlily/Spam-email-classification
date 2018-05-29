clear;
clc;
load('spamData.mat');

%data processing
%use function z_normalization and log_transform and binarization
Xpro = z_normalization(Xtrain);
Xpro1 = z_normalization(Xtest);
Xpro2 = log_transform (Xtrain);
Xpro3 = log_transform (Xtest);
Xpro4 = binarization (Xtrain);
Xpro5 = binarization (Xtest);

%calculate training and testing error rate, use function 
[TRErate, TErate] = LR(Xpro,Xpro1,ytrain,ytest);
[TRErate1, TErate1] = LR(Xpro2,Xpro3,ytrain,ytest);
[TRErate2, TErate2] = LR(Xpro4,Xpro5,ytrain,ytest);

%plot training error rate versus alpha of the different preprocessing strategies
figure;
x = 1 :1 : 10;
plot (x, TRErate(1:10) ,'r-*');
hold on;
plot (x, TRErate1(1:10) , 'b--o');
hold on;
plot (x, TRErate2(1:10) , 'g--+');
hold on;
x = 10 :5 : 100;
plot (x, TRErate(10:28) ,'r-*');
hold on;
plot (x, TRErate1(10:28) , 'b--o');
hold on;
plot (x, TRErate2(10:28) , 'g--+');
hold off;
legend('z-normalized data', 'log-transformed data','binarized data');
xlabel('lambda');
ylabel('Training error rate');

%plot testing error rate versus alpha of the different preprocessing strategies
figure;
x = 1 :1 : 10;
plot (x, TErate(1:10) ,'r-*');
hold on;
plot (x, TErate1(1:10) , 'b--o');
hold on;
plot (x, TErate2(1:10) , 'g--+');
hold on;
x = 10 :5 : 100;
plot (x, TErate(10:28) ,'r-*');
hold on;
plot (x, TErate1(10:28) , 'b--o');
hold on;
plot (x, TErate2(10:28) , 'g--+');
hold off;
legend('z-normalized data', 'log-transformed data','binarized data');
xlabel('lambda');
ylabel('Test error rate');