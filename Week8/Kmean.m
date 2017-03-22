pkg load statistics;
#####################INTIALIZATION######################
clear;
CONVERGENCE = 1000;
N = 4;

mu = {[0, 0],[5,3],[-5,3],[5,5]};

 sigma = [1, 0.1; 0.1, 0.5];
 [X, Y] = meshgrid (linspace (-10, 10, 20));
 XY = [X(:), Y(:)];
 Z1 = mvnpdf (XY, mu{1}, sigma);
 Z2 = mvnpdf (XY, mu{2}, sigma);
 Z3 = mvnpdf (XY, mu{3}, sigma);
 Z4 = mvnpdf (XY, mu{4}, sigma);
 Z= [Z1+Z2+Z3+Z4];
 #mesh (X, Y, reshape (Z, size (X), size (Y)));
 colormap jet;
 Xin = reshape (Z, size (X), size (Y));
 
 muk = {[-1, 1],[4,3],[-4,4],[3,5]};
 ymin = zeros(size(X));
 
 ##########################KMEAN##############################
for cv=1:CONVERGENCE
  for k = 1:4
    for i = 1:size(X)
    for j = 1:size(Y)
      [~,indexmin] = min(Xin(i,j)- muk(k));
    endfor
    endfor
  endfor
endfor