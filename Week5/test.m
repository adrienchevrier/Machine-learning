%%%%%%%%%%%%%%%%%%% clear workspace %%%%%%%%%%%%%%%%%%%
clear;

%%%%%%%%%%%%%%%%%%% import the data %%%%%%%%%%%%%%%%%%%
my_data = importdata('data1_lab4.txt');

%%%%%%%%%%%%%%%%%%% set the dimensions %%%%%%%%%%%%%%%%%%%
%[X] = [IxN] 
%[X_bar] = [Ix(N+1)] 
%[X_barbar] = [Ix_K_] 
%[V] = [(N+1)xK] 
%[F] = [Ix_K_] 
%[F_bar] = [Ix(_K_+1)] 
%[F_barbar] = [IxJ] 
%[W] = [(_K_+1)xJ] 
%[G] = [IxJ] ---> activation function
I = length(my_data(:,1)); % ---> number of set of elements (Input Layer) 
N = 2; % ---> number of parameters 
K = 5; % ---> number of hidden neurones (Hidden Layer) 
J = 2; 

%%%%%%%%%%%%%%%%%%% retrieve data %%%%%%%%%%%%%%%%%%%
X = my_data(:,1:2); %[X] = [IxN] 
Y = my_data(:,3);

% X_bar %
temp1 =  ones(I, 1); 
X_bar = [temp1 X]; %[X_bar] = [Ix(N+1)] 

% weights % 
V = rand(N+1,K); %[V] = [(N+1)xK] 

% X_barbar % 
X_barbar = X_bar * V; %[X_barbar] = [Ix_K_] 

% F % 
F = 1./(1 + exp(-X_barbar)) ; %[F] = [Ix_K_] 

% F_bar % 
temp2 = ones(I,1);
F_bar = [temp2 F];

% weights % 
W = rand(K+1,J); %[W] = [(_K_+1)xJ] 

% F_barbar % 
F_barbar = F_bar * W; %[F_barbar] = [IxJ]

% G %
G = 1./ (1+ exp(-F_barbar));

disp('G');
disp(G);

% learning rate (step size) %
alpha1 = 0.005;
alpha2 = 0.005;

disp('W');
disp(W);
disp('V');
disp(V);

disp('X_barbar');
disp(X_barbar);

%%%%%%%%%%%%%%%%%%% Batch gradient descent %%%%%%%%%%%%%%%%%%%
 for loop = 1:100
    sum1 =0;
    sum2j=0;
    sum2i=0;

     %%%%%%%%%%%%%%%%%%% Forward propagation %%%%%%%%%%%%%%%%%%%
     % W_kj <---- W_kj - alpha1(sum from i=1 to I){G_j(F_bar (X_bar))} - Y_j(i)
     for k = 1:5 % k = {0,...,K}
      for j = 2:2 % j = {1,...,J}
        for i = 1:51 % j = {1,...,I} 
          sum1 = sum1 +  ((G(i,j)-Y(i)) *  G(i,j)  * (1- G(i,j)) * F_bar(i,k))   ;
        end
        W(k,j) = W(k,j) - (alpha1 * sum1); % updating the weight of the neurones
        F_barbar = F_bar * W;
      end 
     end


    %%%%%%%%%%%%%%%%%%% Backward propagation %%%%%%%%%%%%%%%%%%%
    for n = 1:2 % n = {0,...,N}
      for k = 2:5 % j = {1,...,K}
        for i = 1:51 % i = {1,...,I}
          for j = 1:2 % j = {1,...,J}
              sum2j = sum2j + (G(i,j)-Y(i)) * G(i,j) * (1-G(i,j)) * W(k,j) * F(i,k) * (1 - F(i,k)) * X_bar(i,n);
          end
          sum2i= sum2i+sum2j;
        end
        V(n,k) = V(n,k) - (alpha2 * sum2i); % updating the weight of the neurones
        X_barbar = X_bar * V;
      end
    end 
    
 end
 
% final training neurones 
disp('Final training neurones');
disp('W');
disp(W);
disp('V');
disp(V);

disp('New G');
G = 1./ (1+ exp(-F_barbar));
disp(G);

% X
test_X = [0.90440   3.01980]; 
test2_X = [1.60440 2.36478];

% X_bar
test_X_bar = [1 test_X];
test2_X_bar = [1 test_X];

% X_barbar
test_X_barbar = test_X_bar * V;
test2_X_barbar = test_X_bar * V;

% F
test_F = 1./(1 + exp(-test_X_barbar)) ;
test2_F = 1./(1 + exp(-test2_X_barbar)) ;

% F_bar 
test_F_bar = [ones(1, 1) test_F];
test2_F_bar = [ones(1, 1) test2_F];

% F_barbar
test_F_barbar = test_F_bar * W;
test2_F_barbar = test2_F_bar * W;

% G 
test_G = 1./ (1+ exp(-test_F_barbar));
test2_G = 1./ (1+ exp(-test2_F_barbar));

disp('Test G');
disp(test_G);
disp('Test2 G');
disp(test2_G);

test_sum = test_G(1,1) + test_G(1,2);
test2_sum = test2_G(1,1) + test2_G(1,2);

disp(test_sum);
disp(test2_sum);
