pkg load statistics;
#####################INTIALIZATION######################
clear;
%CONVERGENCE = 1000;
%N = 4;
K_SIZE = 100;

mu = [10 20 30 40];

 sigma = [1 2 3 4];
 %[X, Y] = meshgrid (linspace (-10, 10, 20));
 %XY = [X(:), Y(:)];
 Z1 = normrnd (mu(1),sigma(1),2,K_SIZE);
 Z2 = normrnd (mu(2),sigma(2),2,K_SIZE);
 Z3 = normrnd (mu(3),sigma(3),2,K_SIZE);
 Z4 = normrnd (mu(4),sigma(4),2,K_SIZE);
 Z= cat(4,Z1,Z2,Z3,Z4);
 X= Z(1,:);
 Y= Z(2,:);
 %mesh (X, Y, reshape (Z, size (X), size (Y)));
 %colormap jet;
 %Xin = reshape (Z, size (X), size (Y));
%scatter (X, Y);
xlabel ("x");
            ylabel ("y");                       
            
            
title ("Simple 2-D Plot");
% muk = {[-1, 1],[4,3],[-4,4],[3,5]};
% ymin = zeros(size(X));

muk = [20 30 40 45;15 20 20 30];
mukX = [20 30 40 25];
mukY = [30 20 20 40];
scatter(mukX.+X,mukY.+Ys, s, "s", "filled");
colormap jet;

 ##########################KMEAN##############################

 
%for cv=1:CONVERGENCE
 % for k = 1:4
  %  for i = 1:size(X)
   % for j = 1:size(Y)
    %  [~,indexmin] = min(Xin(i,j)- muk(k));
   % endfor
  %  endfor
 % endfor
%endfor