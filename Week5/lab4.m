clear;

my_data=importdata('data1_lab4.txt');

N = 2;
I = length(my_data(:,1));
K = 5;
J = 2;
a1 = 0.04;
a2 = 0.04;

X = my_data(:,1:2);
Y = my_data(:,3);
temp = ones(I,1)
X_bar = [temp X];

V = rand(N+1,K);
W = rand(K+1,J);

X_barbar = X_bar * V;

F= 1./(1+exp(-X_barbar));
 
Fbar = [ones(I,1) F];
Fbarbar = Fbar * W;

G = (1+exp(-Fbarbar))




% calculation of optimal param%
i = 1:I;
j = 2;

for j = 1:J
  for i = 1:K+1
    temp_w(i,j) = [G(i,j)-Y(i)] * G(i,j) * [1 - G(i,j) * Fbar(i,K)];
  end
end
W = W - a1 * temp_w;
for k = 1:K
  for n = 1:N
    for i = 1:I
        temp_v(n,k) = [(G(i,n))-Y(i)] * G(i,n) * [1-G(i,n)] * W(K,n) * [1-F(i,n)] * X_bar(i,n);
    end
  end
end
V = V - a2 * temp_v;
