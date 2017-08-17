%% PIO Study for FDIR 
%  Sam Nazari
%  16 Aug 2017

%% Init Parameters and Dynamic System
clear
clc
Tsim = 5;

% create the dynamic system structure
A = [-1 1;0 -2];
B = [0;1];
C = eye(2);
D = 0;
E = [0;1];

sys = ss(A,B,C,D);

% create initial conditions
X_0 = zeros(2,1);
% observer initial conditions
XI_0= zeros(2,1);
xY_0= rand(2,1);
Xhat_0 = rand(2,1);

%% Observer dynamics
Ax = [A B; 0 0 0]
Bx = [B;0]
Cx = [C zeros(2,1)]

sysObs = ss(Ax,Bx,Cx,0)

[Lx prec] = place(Ax',Cx',[-10,-20,-30])
Lx = Lx'
Lp = Lx(1:2,1:2)
Li = Lx(3,1:2)
Ao = Ax-Lx*Cx;
Ap = A-Lp*C;

%% Simulate Model
sim('PIOModel')

%% Logging and Plotting
e = logsout;
er= e{1}.Values.Data;
t = e{1}.Values.Time;

set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');
figure(1)
plot(t,er(:,1),'b',t,er(:,2),'r','LineWidth',2),xlabel('Time (sec)'), ylabel('State Estimation Error')
title('State Estimation Error'), grid on
xlim([0 1])
ylim([-0.5 0.5])
legend(['x_1 - xHat_1'],['x_2 - xHat_2'])





