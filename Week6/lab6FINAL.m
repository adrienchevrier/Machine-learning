%%%%%%%%%%%%%%%Generate X & Y%%%%%%%%%%%%%%%%
clear;
T=8;
I=30;
a1 = 0.04;
a2 = 0.04;
nn=0.5;
np=1.2;
deltaX = 10.^-3;
deltaS = 10.^-3;
%1 if positive -1 if neg
prevSigndS = 1;
prevSigndX = 1;
%Init x
for i = 1:I
  x(i,:)= rand(1,T)<.5;
end

%Init y
for i = 1:I
  y(i,1)=sum([x(i,:)]);
 end
 

Vx = rand(1);
Vs = rand(1);
S= zeros(I,T+1);


for a = 1:1000
%%%%%%%%%%%%%%%%%%%%Forward propagation%%%%%%%%%%%%%%%%%%
  for i = 1:I
    for t = 1:T
      S(i,t+1)= S(i,t)*Vs+x(i,t)*Vx;
     end
  end
  ym=S(:,T+1);

%%%%%%%%%%%%Resilient propagation%%%%%%%%%%%%%%%%%%%%%%%%%
dEdVx = 0;
 dEdVs = 0;
  for i = 1:I
  
    for t = 1:T
      dEdVx = dEdVx + [(ym(i)-y(i)) * x(i,t)].* Vs.^(T-t);
    end
  end

  for i = 1:I
 
    for t = 2:T
      dEdVs = dEdVs + [(ym(i)-y(i)) * S(i,t-1)].* Vs.^(T-t);
    end
  end


  if(prevSigndX==sign(dEdVx))
    deltaX = np * deltaX;
  else
    deltaX = nn * deltaX;
  endif

  if(prevSigndS==sign(dEdVs))
    deltaS = np * deltaS;
  else
    deltaS = nn * deltaS;
  endif

  prevSigndX = sign(dEdVx);
  prevSigndS = sign(dEdVs);

  Vx = Vx - sign(dEdVx) * deltaX;
  Vs = Vs - sign(dEdVs) * deltaS;
  
  %%%%%%%%%%%%%%%%%%%Backward propagation%%%%%%%%%%%%

  %Vx = Vx-a1 * dEdVx;
  %Vs = Vs-a2 * dEdVs;


end






%%%%%%%%%%%%%%%%%%%%%%%Tests%%%%%%%%%%%%%% 
X_test = x;
Y_real = y;

Y_test=zeros(I,T+1);
for i=1:I
  for t=1:T
      Y_test(i,t+1) = X_test(i,t)*Vx + Y_test(i,t)*Vs;
  end
end



Y_test=int8(Y_test);
compt = 0;
for i=1:I

    if(Y_test(i,T+1) == Y_real(i))
        compt = compt +1;
    end    
end
a = compt * 100 / I;
fprintf('accuracy:%f \n',a);

