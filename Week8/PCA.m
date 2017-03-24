%%%%%%%%%%%%%%%%%%Pre processing%%%%%%%%%%%%%%%
clear;
I = 100;

% generate input data
X =100*rand(I, 1); 
Y = X + 20 + 5*rand(I, 1); 
data = [X Y];

% training data
figure;
scatter(X,Y,'b','filled');
hold on


%Mean
mu = mean(X);
data-=mu;

%Normalize
sigma =  (data' * data)/I;

%%%%%%%%%%%%%%%PCA Algorithm%%%%%%%%%%%%%%%%
%compute singular value decomposition to get most significant eigenvectors
[U,~,~]= svd(sigma);
%Get most significant eigenvector
Uimp = U(:, 1);
%project X~ on U =>Y~
Y =  data * Uimp;
Xout = zeros(1:I,1);
Yout = zeros(1:I,1);

%Get X and Y
for i=1:I
Xout(i) =   -[X(i,1).*Uimp(2, :)];
Yout(i) =[ Y(i,1).*Uimp(1, :)];
endfor
%plot(Y(:,1), zeros(I, 1), 'r');
scatter(Xout, Yout, 'm');
hold on


%%%%%%%%%%TEST%%%%%%%%%%%
I = 40
Xtest =100*rand(I, 1); 
Ytest = Xtest + 20 + 5*rand(I, 1); 
data = [Xtest Ytest];

scatter(Xtest,Xtest,'y','s');
hold on

data-=mu;


% Project the test data set onto U
Xfinal = Xtest * Uimp(1, :);
Yfinal = Ytest * Uimp(2, :);

%Get X and Y
for i=1:I
Xouttest(i) = [Xfinal(i,1).*Uimp(2, :)];
Youttest(i) =[ Yfinal(i,1).*Uimp(1, :)];
endfor
%Print data
scatter(Xouttest, Youttest, 'r','s');
title 'PCA';
legend('Data train', 'out', 'Test data', 'Test out');
hold on