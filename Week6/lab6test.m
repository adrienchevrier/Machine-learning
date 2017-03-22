%%%%%%%%%%%%%%%Generate X & Y%%%%%%%%%%%%%%%%
T=8;
I=30;
a1 = 0.04;
a2 = 0.04;
%Init x
for i = 1:I
  x(i,:)= rand(1,T)<.5;
end

%Init y
for i = 1:I
  y(i)=sum([x(i,:)]);
 end
 
%%%%%%%%%%%%%%%%%%%%Forward propagation%%%%%%%%
Vx = rand(1,T)<.5;
Vs = rand(1,T)<.5;
S= zeros(I,T);
for i = 1:I
  for t = 2:T
    S(i,t)= S(i,t-1)*Vs(t)+x(i,t)*Vx(t);
   end
end
ym=S(:,T);


for t = 1:T
  for i = 1:I
    dEdVx(t) = [(ym(i)-y(i)) * x(i,t)] * Vs(T-t+1);
  end
end

for t = 2:T
  for i = 1:I
    dEdVs(t) = [(ym(i)-y(i)) * S(i,t-1)] * Vs(T-t+1);
  end
end
%%%%%%%%%%%%%%%%%%%Backward propagation%%%%%%%%%%%%
for t = 1:T
  Vx(t) = Vx(T)-a1 * dEdVx(t);
end

for t = 1:T
  Vs(t) = Vs(T)-a2 * dEdVs(t);
end
