###########################bellman equations####################################


function Vpi = Bellman1(Slin,Scol,R,gamma,V1,P)
Vpitemp = P(1) * V1(Slin,Scol-1) +P(2) * V1(Slin-1,Scol)+P(3) * V1(Slin,Scol+1);
Vpi = R(Slin,Scol)+gamma * Vpitemp;
endfunction

function Vpi = Bellman2(Slin,Scol,R,gamma,V2,P)
Vpitemp = P(1) * V2(Slin,Scol+1) +P(2) * V2(Slin+1,Scol)+P(3) * V2(Slin,Scol-1);
Vpi = R(Slin,Scol)+gamma * Vpitemp;
endfunction

function Vpi = Bellman3(Slin,Scol,R,gamma,V3,P)
Vpitemp = P(1) * V3(Slin-1,Scol) +P(2) * V3(Slin,Scol+1)+P(3) * V3(Slin+1,Scol);
Vpi = R(Slin,Scol)+gamma * Vpitemp;
endfunction

function Vpi = Bellman4(Slin,Scol,R,gamma,V4,P)
Vpitemp = P(1) * V4(Slin+1,Scol) +P(2) * V4(Slin,Scol-1)+P(3) * V4(Slin-1,Scol);
Vpi = R(Slin,Scol)+gamma * Vpitemp;
endfunction

################################################################################