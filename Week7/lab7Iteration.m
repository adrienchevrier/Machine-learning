clear;
I = 3
J = 4
CONVERGENCE = 200
gamma = 0.99
for i = 1:I+2
  for j = 1:J+2
    R(i,j) = -0.02
    V(i,j) = 0
    Vmax(i,j) = 0
    pi(i,j) = "-"
  end
end
do
  Scol =floor(1+(4)*rand())+1
  Slin = floor(1+(3)*rand())+1
  maxpi = 3
until(R(Slin,Scol)!=-9)
R(2,5) = 1
R(3,5) = -1
R(3,3) = -9
R(1,4) = 1
R(1,1:6) = -9
R(2:4,1) = -9
R(5,1:6) = -9
R(2:4,6) = -9

A = ["N","S","E","W"]#N S E W
P = [0.1,0.8,0.1]

for a = 1:CONVERGENCE
#Move robot
  pass = 0;
  do
    if((maxpi == 1) && (R(Slin-1,Scol)>(-9)))
      Slin = Slin-1;
      pass = 1;
    elseif((maxpi == 2) && (R(Slin+1,Scol)>(-9)))
      Slin = Slin+1;
      pass = 1;
    elseif((maxpi == 3) && (R(Slin,Scol+1)>(-9)))
      Scol = Scol+1;
      pass = 1;
   elseif((maxpi == 4) && (R(Slin,Scol-1)>(-9)))
      Scol = Scol-1;
      pass = 1;
    else
     maxpi = floor(1+(4)*rand());
    endif
  until(pass == 1)#do until to avoid going through walls
  pass = 0;
  #Psa and Value calculation
  PsaV(1) = P(1) * V(Slin,Scol-1) +P(2) * V(Slin-1,Scol)+P(3) * V(Slin,Scol+1);
  PsaV(2) = P(1) * V(Slin,Scol+1) +P(2) * V(Slin+1,Scol)+P(3) * V(Slin,Scol-1);
  PsaV(3) = P(1) * V(Slin-1,Scol) +P(2) * V(Slin,Scol+1)+P(3) * V(Slin+1,Scol);
  PsaV(4) = P(1) * V(Slin+1,Scol) +P(2) * V(Slin,Scol-1)+P(3) * V(Slin-1,Scol);
  [maxPsaV, maxpi] = max(PsaV);
  V(Slin,Scol) = R(Slin,Scol)+gamma * maxPsaV;
  pi(Slin,Scol) = A(maxpi);
  #change action and value if new max value found
  #if(V(Slin,Scol)>=Vmax(Slin,Scol))
  #  Vmax(Slin,Scol) = V(Slin,Scol);
  #  pi(Slin,Scol) = A(maxpi);
  #endif
  #Replace robot randomly if max reward found
  if(R(Slin,Scol)==1)
    do
      Scol = floor(1+(4)*rand())+1;
      Slin = floor(1+(3)*rand())+1;
      maxpi = floor(1+(4)*rand());
    until(R(Slin,Scol)>-9)#do until to avoid walls
  endif
end


