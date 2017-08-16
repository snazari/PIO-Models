%% PIO Study for FDIR 
%  Sam Nazari
%  16 Aug 2017

%% Init Parameters and Dynamic System
clear
clc

% create the dynamic system structure
A = [-1 1;0 -2];
B = [0;1];
C = eye(2);
D = 0;
E = [0;1];

sys = ss(A,B,C,D);

% create initial conditions
X_0 = zeros(2,1);

%% Observer dynamics

% observer initial conditions
XI_0= zeros(2,1);

Ax = [A B; 0 0 0]
Bx = [B;0]
Cx = [C zeros(2,1)]

sysObs = ss(Ax,Bx,Cx,0)

[Lx prec] = place(Ax',Cx',[-10,-20,-30])

Ao = Ax-Lx'*Cx;



