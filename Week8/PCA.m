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
%project X~ ont U =>Y~
Y =  data * Uimp;
for i=1:I
Xout = Uimp'(:, 1) * i;
Yout = Uimp'(:, 2) * i;
endfor
plot(Y(:,1), zeros(I, 1), 'r');
plot(Xout, Yout, 'g');
hold on