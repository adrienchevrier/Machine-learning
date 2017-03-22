%Generate 30 sequences of 8 bits
%Predict the sum

%Generating X and y
X = zeros(30,8);
y = zeros(30,1);
for i=1:30
  for j=1:8
    r = rand(1);
    if(r>=0.5)
      X(i,j) = 1;
      y(i) = y(i) + 1;
    endif
  end
end

%Initializing variables
g = zeros(30,1);
x = zeros(30,8);
Vx = 1;
Vs = 1;
sdEVs = rand(1);
sdEVx = rand(1);
dX = 10^(-3);
dS = dX;

%Looping 1000 times
for k=1:1000
  %FORWARD PROPAGATION
  for i=1:30
    s = 0;
    for j=1:8
      s = X(i,j)*Vx + s*Vs;
      x(i,j) = s;
    end;
    g(i) = s;
  end
  
  %BACKWARD PROPAGATION
  %Calculating dE/dVx and dE/dVs
  dEVx = 0;
  dEVs = 0;
  for i=1:30
    for j=1:8
      dEVx = dEVx + (g(i)-y(i))*x(i,j)*Vs^(8-j);
      if(j>1) dEVs = dEVs + (g(i)-y(i))*x(i,j-1)*Vs^(8-j); endif
    end
  end
  %Correcting dX and dS
  if(sign(dEVx) == sdEVx)
    dX = dX*1.2;
  else
    dX = dX*0.5;
  endif
  if(sign(dEVs) == sdEVs)
    dS = dS*1.2;
  else
    dS = dS*0.5;
  endif
  %Correcting Vx and Vs
  sdEVx = sign(dEVx);
  sdEVs = sign(dEVs);
  Vx = Vx - sdEVx*dX;
  Vs = Vs - sdEVx*dS;
end