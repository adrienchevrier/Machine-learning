%pkg load statistics;
#####################INTIALIZATION######################
clear;
CONVERGENCE = 500;
K = 4;
K_SIZE = 100;
I = K_SIZE*K;

%Random gaussian init
muX = [10 20 30 40];
muY = [20 40 30 10];
 sigma = [1 1,2 2 0,5];

 Z1 = normrnd (muX(1),sigma(1),1,K_SIZE);
 Z2 = normrnd (muX(2),sigma(2),1,K_SIZE);
 Z3 = normrnd (muX(3),sigma(3),1,K_SIZE);
 Z4 = normrnd (muX(4),sigma(4),1,K_SIZE);
 Z= cat(4,Z1,Z2,Z3,Z4);
 X= Z(1,:);
 Z1 = normrnd (muY(1),sigma(1),1,K_SIZE);
 Z2 = normrnd (muY(2),sigma(2),1,K_SIZE);
 Z3 = normrnd (muY(3),sigma(3),1,K_SIZE);
 Z4 = normrnd (muY(4),sigma(4),1,K_SIZE);
 Z= cat(4,Z1,Z2,Z3,Z4);
 Y= Z(1,:);



%Init centroids%
%muk = [20 30 40 45;15 20 20 30];
mukX = 50*rand(1,4);
mukY = 50*rand(1,4);

ins = zeros(K,I);
clf;
hold on;
scatter(X,Y,"r");
scatter(mukX,mukY,"b","filled");
xlabel ("");
ylabel ("");                                 
title ("2-D Plot Starting data");
hold off
 ##########################KMEAN##############################

 
for cv=1:CONVERGENCE
ins = zeros(K,I);
  for i = 1:I
  %Calculate distance
    Xtemp = X(i)-mukX;
    Ytemp = Y(i)-mukY;
    for k =1:K
      dist(k) = norm([Xtemp(k); Ytemp(k)]);
    endfor
    %take best distance
    [~,yk(i)] = min(dist);
    ins(yk(i),i) = 1;
  endfor
  %Calculate new mu
  for k =1:K

    if(sum(ins(k,:))!=0)
    div = sum(ins(k,:));
    mukX(k) = (sum(ins(k,:).*X))/(div);
    mukY(k) = (sum(ins(k,:).*Y))/(div);
    else 
    %change position if mu has no cluster
        mukX(k) = 50*rand(1,1); 
        mukY(k) = 50*rand(1,1);
    endif

  endfor

endfor


%Print new mu 
clf;
hold on;
%scatter(X,Y,"r");
for i = 1:I
  switch yk(i)
    case 1
    X1(end+1) = X(i);
    Y1(end+1) = Y(i);
    case 2
    X2(end+1) = X(i);
    Y2(end+1) = Y(i);
    case 3
    X3(end+1) = X(i);
    Y3(end+1) = Y(i);
    case 4
    X4(end+1) = X(i);
    Y4(end+1) = Y(i); 
 end
end 
    
scatter(X1,Y1,'m','s');
hold on
scatter(X2,Y2,'y','s');
hold on
scatter(X3,Y3,'g','s');
hold on
scatter(X4,Y4,'r','s');
scatter(mukX,mukY,"b","filled");
xlabel ("");
ylabel ("");                                 
title ("2-D Plot after training");
hold off;



% Test Model with new Data

 sigma = [1 1 0.9 1.1];
 % New data input
 K_SIZE = 20;
I = K_SIZE * K;

 Z1 = normrnd (muX(1),sigma(1),1,K_SIZE);
 Z2 = normrnd (muX(2),sigma(2),1,K_SIZE);
 Z3 = normrnd (muX(3),sigma(3),1,K_SIZE);
 Z4 = normrnd (muX(4),sigma(4),1,K_SIZE);
 Z= cat(4,Z1,Z2,Z3,Z4);
 Xtest= Z(1,:);
 Z1 = normrnd (muY(1),sigma(1),1,K_SIZE);
 Z2 = normrnd (muY(2),sigma(2),1,K_SIZE);
 Z3 = normrnd (muY(3),sigma(3),1,K_SIZE);
 Z4 = normrnd (muY(4),sigma(4),1,K_SIZE);
 Z= cat(4,Z1,Z2,Z3,Z4);
 Ytest= Z(1,:);





% For each output
for i = 1:I
  %Update y(i)
  % For each cluster
  %Calculate distance
    Xtemp = Xtest(i)-mukX;
    Ytemp = Ytest(i)-mukY;
    for k =1:K
      dist(k) = norm([Xtemp(k); Ytemp(k)]);
    endfor
    %take best distance
    [~,nyk(i)] = min(dist);
endfor



%scatter(X,Y,"r");
for i = 1:I
  switch nyk(i)
    case 1
    Xtest1(end+1) = Xtest(i);
    Ytest1(end+1) = Ytest(i);
    case 2
    Xtest2(end+1) = Xtest(i);
    Ytest2(end+1) = Ytest(i);
    case 3
    Xtest3(end+1) = Xtest(i);
    Ytest3(end+1) = Ytest(i);
    case 4
    Xtest4(end+1) = Xtest(i);
    Ytest4(end+1) = Ytest(i); 
 end
end 
    
figure;
clf;
scatter(Xtest,Ytest,'m','s');
scatter(Xtest1,Ytest1,'m','s');
hold on
scatter(Xtest2,Ytest2,'y','s');
hold on
scatter(Xtest3,Ytest3,'g','s');
hold on
scatter(Xtest4,Ytest4,'r','s'); 
scatter(mukX,mukY,"b","filled");
xlabel ("");
ylabel ("");                                 
title ("2-D Plot after test");
hold off;