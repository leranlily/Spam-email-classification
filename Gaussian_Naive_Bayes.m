clear;
clc;
load('spamData.mat');

%data processing
%use function z_normalization and log_transform 
Xpro = z_normalization(Xtrain);
Xpro1 = z_normalization(Xtest);
Xpro2 = log_transform (Xtrain);
Xpro3 = log_transform (Xtest);

%calculate training and testing error rate, use function GNB
[TRErate, TErate] = GNB(Xpro,Xpro1,ytrain,ytest);
[TRErate1, TErate1] = GNB(Xpro2,Xpro3,ytrain,ytest);

%print training and testing error rate on command window
fprintf('When data processing is z-normalization\n');
fprintf('Training error rate£º%d  Test error rate£º%d\n\n',[TRErate TErate]);
fprintf('When data processing is log-tramsform\n');
fprintf('Training error rate£º%d  Test error rate£º%d\n',[TRErate1 TErate1]);