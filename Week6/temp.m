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
x=round(rand(I,T));

%Init y
y = sum(x')';
 
%%%%%%%%%%%%%%%%%%%%Forward propagation%%%%%%%%%%%%%%%%%%
Vx = rand(1);
Vs = rand(1);
S= zeros(I,T+1);


for a = 1:1000

  for i = 1:I
    for t = 1:T
      S(i,t+1)= S(i,t)*Vs+x(i,t)*Vx;
     end
  end
  ym=S(:,T+1);


        for j=1:8
            dX(1,j) = sum((ym - y).*x(:,j));
            dS(1,j) = sum((ym - y).*S(:,j));
        end
  
        dEdVx = 0;
        dEdVs = 0; 

        
        for w=1:8
            dEdVx = dEdVx + dX(1,w)*(Vx.^(8-w));
            dEdVs = dEdVs + dS(1,w)*(Vx.^(8-w));
        end
 
%%%%%%%%%%%%Resilient propagation%%%%%%%%%%%%%%%%%%%%%%%%%
  if(prevSigndX==sign(dEdVx))
    deltaX = np * deltaX;
  end
  
  if(prevSigndX~=sign(dEdVx))
    deltaX = nn * deltaX;
  end

  if(prevSigndS==sign(dEdVs))
    deltaS = np * deltaS;
  end
  
  if(prevSigndS~=sign(dEdVs))
    deltaS = nn * deltaS;
  end

  prevSigndX = sign(dEdVx);
  prevSigndS = sign(dEdVs);

  Vx = Vx - sign(dEdVx) * deltaX;
  Vs = Vs - sign(dEdVs) * deltaS;

end

%%%%%%%%%%%%%%%%%%%Backward propagation%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%Tests%%%%%%%%%%%%%% 
X_test = x;%round(rand(I,T));
Y_real = y;%sum(X_test')';

Y_test=zeros(T+1,I);
for i=1:I
  for t=1:T
      Y_test(T+1,i) = X_test(i,t)*Vx + Y_test(t,i)*Vs;
  end
end



Y_test=int8(Y_test);
compt = 0;
for i=1:I

    if(Y_test(T+1,i) == Y_real(i))
        compt = compt +1;
    end    
end
accuracy = compt * 100 / I;
fprintf('The training accuracy is %f \n',accuracy);

