clear;
m = 30;
X = round(rand(m,8));
Y = sum(X')';


Vx = rand(1);
Vs = rand(1);

hidden = zeros(m,9);
Y_estime = zeros(m,1);

deltaX = 0.001;
deltaS = 0.001;
dE_dX = zeros(m,1);
dE_dS = zeros(m,1); 



%Intermediaires
dX = zeros(1,8);
dS = zeros(1,8);
prevSigndS = 1;
prevSigndX = 1;

nn=0.5;
np=1.2;


for a=1:1000
 
  
    for i=1:m

        for j=1:8
            hidden(i,j+1) = X(i,j)*Vx + hidden(i,j)*Vs;
        end
        
    end
    Y_estime = hidden(:,9);
    
        for j=1:8
            dX(1,j) = sum((Y_estime - Y).*X(:,j));
            dS(1,j) = sum((Y_estime - Y).*hidden(:,j));
        end
  
        dE_dX = 0;
        dE_dS = 0; 

        
        for w=1:8
            dE_dX = dE_dX + dX(1,w)*(Vx.^(8-w));
            dE_dS = dE_dS + dS(1,w)*(Vx.^(8-w));
        end
        
        %compare signs of deltas
        if (prevSigndX == sign(dE_dX))
            deltaX = deltaX * np;
        end

        if (prevSigndX ~= sign(dE_dX))
            deltaX = deltaX * nn;
        end

        if (prevSigndS == sign(dE_dS))
            deltaS = deltaS * np;
        end

        if (prevSigndS ~= sign(dE_dS))
            deltaS = deltaS * nn;
        end
  
        %Update prevsign
        prevSigndX = sign(dE_dX);
        prevSigndS = sign(dE_dS);
     
        %Resilient propagation
        Vx = Vx - sign(dE_dX(1,1))*deltaX;
        Vs = Vs - sign(dE_dS(1,1))*deltaS;
  
       
     
  end


%validation 
Y_test=zeros(9,m);
for n=1:m
  for j=1:8
      Y_test(j+1,n) = X(n,j)*Vx + Y_test(j,n)*Vs;
  end
end

Y_test=int8(Y_test);
compt = 0;
for i=1:m

    if(Y_test(9,i) == Y(i))
        compt = compt +1;
    end    
end
accuracy = compt * 100 / m;
fprintf('The training accuracy is %f \n',accuracy);