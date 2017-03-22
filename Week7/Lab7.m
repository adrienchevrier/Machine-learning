########################Initialization##############################
clear;
I = 3
J = 4
CONVERGENCE = 1000
gamma = 0.9
for i = 1:I+2
  for j = 1:J+2
    R(i,j) = -0.02
    V(i,j) = 0
    Vmax(i,j) = 0
    pi(i,j) = 0
  end
end
do
  Scol =floor(1+(4)*rand())+1
  Slin = floor(1+(3)*rand())+1
until(Scol!=3 & Slin!=3)
R(2,5) = 1
R(3,5) = -1
R(3,3) = -9
R(1,4) = 1
R(1,1:6) = -9
R(2:4,1) = -9
R(5,1:6) = -9
R(2:4,6) = -9

A = ['N','S','E','W']
P = [0.1,0.8,0.1]

##############Find best path value iteration#################
for a = 1:CONVERGENCE
  #Psa and Value calculation
  PsaV(1) = P(1) * V(Slin,Scol-1) +P(2) * V(Slin-1,Scol)+P(3) * V(Slin,Scol+1)
  PsaV(2) = P(1) * V(Slin,Scol+1) +P(2) * V(Slin+1,Scol)+P(3) * V(Slin,Scol-1)
  PsaV(3) = P(1) * V(Slin-1,Scol) +P(2) * V(Slin,Scol+1)+P(3) * V(Slin+1,Scol)
  PsaV(4) = P(1) * V(Slin+1,Scol) +P(2) * V(Slin,Scol-1)+P(3) * V(Slin-1,Scol)
  [maxPsaV, maxpi] = max(PsaV)
  #Max value calculation
  V(Slin,Scol) = R(Slin,Scol)+gamma * maxPsaV
  #Change if max value found
  if(V(Slin,Scol)>Vmax(Slin,Scol))
    Vmax(Slin,Scol) = V(Slin,Scol)
    pi(Slin,Scol) = A(maxpi)
  endif
  #Determine next position
  if((pi == 'N')& (R(Slin-1,Scol)!=-9))
    [Slin, Scol] = [Slin-1,Scol]
  endif
  if((pi == 'E')& (R(Slin,Scol+1)!=-9))
    [Slin, Scol] = [Slin,Scol+1]
  endif
  if((pi == 'S')& (R(Slin+1,Scol)!=-9))
    [Slin, Scol] = [Slin+1,Scol]
  endif
  if((pi == 'W')& (R(Slin,Scol-1)!=-9))
    [Slin, Scol] = [Slin,Scol-1]
  endif
end
  
  