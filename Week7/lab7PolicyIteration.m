1;
clear;
source("Week7/bellman.m");
########################Initialization##############################

I = 3
J = 4
CONVERGENCE = 20000
gamma = 0.99
for i = 1:I+2
  for j = 1:J+2
    R(i,j) = -0.02;
    V(i,j) = 0;
    Vmax(i,j) = 0;
    pi(i,j) = "-";
    V1(i,j)=0;
    V2(i,j)=0;
    V3(i,j)=0;
    V4(i,j)=0;
  end
end
do
  Scol =floor(1+(4)*rand())+1
  Slin = floor(1+(3)*rand())+1
  maxpi = 3
until(R(Slin,Scol)!=-9)
R(2,5) = 1;
R(3,5) = -1;
R(3,3) = -9;
R(1,1:6) = -9;
R(2:4,1) = -9;
R(5,1:6) = -9;
R(2:4,6) = -9;
V1(2,5) = 1;
V2(2,5) = 1;
V3(2,5) = 1;
V4(2,5) = 1;

A = ["N","S","E","W"]#N S E W
P = [0.1,0.8,0.1]
###################################################################

for a = 1:CONVERGENCE
#Move robot
  pass = 0;
  do
    if((pi(Slin,Scol) == "N") && (R(Slin-1,Scol)>(-9)))
      Slin = Slin-1;
      pass = 1;
    elseif((pi(Slin,Scol) == "S") && (R(Slin+1,Scol)>(-9)))
      Slin = Slin+1;
      pass = 1;
    elseif((pi(Slin,Scol) == "E") && (R(Slin,Scol+1)>(-9)))
      Scol = Scol+1;
      pass = 1;
   elseif((pi(Slin,Scol) == "W") && (R(Slin,Scol-1)>(-9)))
      Scol = Scol-1;
      pass = 1;
    else
     pi(Slin,Scol) = A(floor(1+(4)*rand()));
    endif
  until(pass == 1)#do until to avoid going through walls
  pass = 0;
  #Bellmann calculation
  #if(strncmp(pi(Slin,Scol),"-",1)==1)
   # pi(Slin,Scol)= "N"#floor(1+(4)*rand());
#endif

    switch pi(Slin,Scol)
      case "N"
       V1(Slin,Scol)=Bellman1(Slin,Scol,R,gamma,V1,P);
       V(Slin,Scol)=V1(Slin,Scol);
      case "S"
       V2(Slin,Scol)=Bellman2(Slin,Scol,R,gamma,V2,P);
       V(Slin,Scol)=V2(Slin,Scol);
      case "E"
       V3(Slin,Scol)=Bellman3(Slin,Scol,R,gamma,V3,P);
       V(Slin,Scol)=V3(Slin,Scol);
      case "W"
       V4(Slin,Scol)=Bellman4(Slin,Scol,R,gamma,V4,P);
       V(Slin,Scol)=V4(Slin,Scol);
  end

  PsaV(1) = P(1) * V(Slin,Scol-1) +P(2) * V(Slin-1,Scol)+P(3) * V(Slin,Scol+1);
  PsaV(2) = P(1) * V(Slin,Scol+1) +P(2) * V(Slin+1,Scol)+P(3) * V(Slin,Scol-1);
  PsaV(3) = P(1) * V(Slin-1,Scol) +P(2) * V(Slin,Scol+1)+P(3) * V(Slin+1,Scol);
  PsaV(4) = P(1) * V(Slin+1,Scol) +P(2) * V(Slin,Scol-1)+P(3) * V(Slin-1,Scol);
  [maxPsaV, maxpi] = max(PsaV);
  pi(Slin,Scol) = A(maxpi);

  #change action and value if new max value found
  if(V(Slin,Scol)>=Vmax(Slin,Scol))
    Vmax(Slin,Scol) = V(Slin,Scol);
    pimax(Slin,Scol) = A(maxpi);
  endif
  #Replace robot randomly if max reward found
  if(R(Slin,Scol)==1)
    do
      Scol =floor(1+(4)*rand())+1;
      Slin =floor(1+(3)*rand())+1;
      maxpi = floor(1+(4)*rand());
    until(R(Slin,Scol)>-9)#do until to avoid walls
  endif

end