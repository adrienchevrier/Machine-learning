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
for i=1:I
Xout(i) =   -[X(i,1).*Uimp(2, :)];
Yout(i) =[ Y(i,1).*Uimp(1, :)];
endfor
%plot(Y(:,1), zeros(I, 1), 'r');
scatter(Xout, Yout, 'm');
hold on