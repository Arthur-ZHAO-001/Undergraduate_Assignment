%% 4.1 

clear,clc,close all
tau=three_dof_dynamics([10;20;30],[1;2;3],[0.5;1;1.5])
tau;

%% 4.2
clc;
clear;

L(1)=Link('d',0,'a',1,'alpha',0, 'm',19.515, 'r',[0,0.5,0], 'I', [0.0813 0 0;0 1.6303 0;0 0 1.6303]);
L(2)=Link('d',0,'a',0.5,'alpha',0, 'm',9.7575, 'r',[0,0.25,0], 'I', [0.0406 0 0;0 0.8152 0;0 0 0.8152]);
robot = SerialLink(L);
robot.name = 'X';

temp = [pi/18 pi/2];
q = [];
t = [0:0.01:1]';
for i=1:102
    T0 = robot.fkine(temp).t;
    T1 = transl([T0(1), T0(2)+0.005, T0(3)]);
    temp=robot.ikine(T1,temp, 'mask',[1, 1, 0, 0, 0, 0]);
    q = [q;temp];
end

temp1 = q;
q = q(2:end,:);

figure('color','w');
title("题4.2")

subplot(2,2,1);
plot(t,q);
grid on;title('角度');

subplot(2,2,2);
qd = diff(temp1)/0.01;
plot(t,qd);
grid on;title('角速度');

subplot(2,2,3);
temp2 = [0, 0; qd];
qdd = diff(temp2)/0.01;
plot(t,qdd);
grid on;title('角加速度');

subplot(2,2,4);
tu = robot.rne(q,qd,qdd);
plot(t,tu(:,1));
hold on
plot(t,tu(:,2));
grid on;title('关节力矩');

%% 4.3 
clc;
clear;

theta(1) = 0; d(1) = 0; a(1) = 0; alp(1) = 0;
theta(2) = 0; d(2) = 0; a(2) = 4; alp(2) = 0;
theta(3) = 0; d(3) = 0; a(3) = 3; alp(3) = 0;


L(1) = Link([theta(1), d(1), a(1), alp(1)], 'modified');
L(2) = Link([theta(2), d(2), a(2), alp(2)], 'modified');
L(3) = Link([theta(3), d(3), a(3), alp(3)], 'modified');

L(1).m = 20; L(2).m = 15; L(3).m = 10;
L(1).r = [2 0 0];
L(2).r = [1.5 0 0];
L(3).r = [1 0 0];

L(1).I = [0 0 0; 0 0 0; 0 0 0.5];
L(2).I = [0 0 0; 0 0 0; 0 0 0.2];
L(3).I = [0 0 0; 0 0 0; 0 0 0.1];

L(1).Jm = 0;
L(2).Jm = 0;
L(3).Jm = 0;

robot = SerialLink(L,'gravity',[0,9.8,0]); 
robot.name = 'robot';

q0 = [-60,90,30]*pi/180;
qd0 = [0,0,0];
tor = [20,5,1]';

q_list_1 = [q0(1)];
q_list_2 = [q0(2)];
q_list_3 = [q0(3)];
qd_list_1 = [qd0(1)];
qd_list_2 = [qd0(2)];
qd_list_3 = [qd0(3)];
G0 = robot.gravload([0,0,0]);
disp(robot.inertia([0,0,0]));
disp(robot.gravload([0,0,0]));
C = robot.coriolis(q0,qd0);

for i=0:0.01:4
    M_inv = inv(robot.inertia(q0));
    C = robot.coriolis(q0,qd0);
    G = robot.gravload(q0);
    qdd = M_inv*(tor-C*qd0'-G');
    qd = qd0 + qdd'*0.01;
    q = q0 + qd0*0.01+0.5*qdd'*0.01*0.01;
    qd0 = qd;
    q0 = q;
    q_list_1(end+1) = q0(1);
    q_list_2(end+1) = q0(2);
    q_list_3(end+1) = q0(3);
    qd_list_1(end+1) = qd0(1);
    qd_list_2(end+1) = qd0(2);
    qd_list_3(end+1) = qd0(3);
end

t = 0:0.01:4;
figure(1);
plot(t,q_list_1(1:401));
hold on;
plot(t,q_list_2(1:401));
hold on;
plot(t,q_list_3(1:401));

figure(2);
plot(t,qd_list_1(1:401));
hold on;
plot(t,qd_list_2(1:401));
hold on;
plot(t,qd_list_3(1:401));
title("题4.3")

path =[0.05 0.05 0.02;0.05 0.05 0.08;-0.05 0.05 0.02;-0.05 0.05 0.08;0.05 0.05 0.02]
%% 4.1 中的辅助函数

function tau = three_dof_dynamics(theta, theta_d, theta_dd)

% 参数：（运动指令）各关节运动角度， 关节速度， 关节加速度（3*1矩阵）
% 返回值：各关节力矩（3*1矩阵）
% D-H参数表
th(1) = theta(1)*pi/180; d(1) = 0; a(1) = 0; alp(1) = 0;
th(2) = theta(2)*pi/180; d(2) = 0; a(2) = 4; alp(2) = 0;
th(3) = theta(3)*pi/180; d(3) = 0; a(3) = 3; alp(3) = 0;
% base_link的各项初始值
w00 = [0; 0; 0]; v00 = [0; 0; 0]; w00d = [0; 0; 0]; v00d = [0; 9.8; 0];
% 各关节p及各link质心pc的距离(假设质心在几何中心)
p10 = [0; 0; 0]; p21 = [4; 0; 0]; 
p32 = [3; 0; 0]; p43 = [2; 0; 0]; 
pc11 = [2; 0; 0]; pc22 = [1.5; 0; 0]; 
pc33 = [1; 0; 0];
z = [0; 0; 1];
% 各连杆质量
m1 = 20; m2 = 15; m3 = 10;
% 惯性张量
I1 = [0 0 0; 0 0 0; 0 0 0.5]; I2 = [0 0 0; 0 0 0; 0 0 0.2]; I3 = [0 0 0; 0 0 0; 0 0 0.1];
% 各齐次矩阵function T = MDHTrans(alpha, a, d, theta)
T01 = MDHTrans(alp(1), a(1), d(1), th(1));
T12 = MDHTrans(alp(2), a(2), d(2), th(2));
T23 = MDHTrans(alp(3), a(3), d(3), th(3));
R01 = T01(1:3, 1:3); R12 = T12(1:3, 1:3); R23 = T23(1:3, 1:3);
R10 = R01'; R21 = R12'; R32 = R23';
R34 = [1 0 0; 0 1 0; 0 0 1];
%% Outward iterations: i: 0->2
% i = 0 连杆1
w11 = R10*w00 + theta_d(1)*z;
w11d = R10*w00d + cross(R10*w00, z*theta_d(1)) + theta_dd(1)*z;
v11d = R10*(cross(w00d, p10) + cross(w00, cross(w00, p10)) + v00d);
vc11d = cross(w11d, pc11) + cross(w11, cross(w11, pc11)) + v11d;
F11 = m1*vc11d;
N11 = I1*w11d + cross(w11, I1*w11);
% i = 1 连杆2
w22 = R21*w11 + theta_d(2)*z;
w22d = R21*w11d + cross(R21*w11, z*theta_d(2)) + theta_dd(2)*z;
v22d = R21*(cross(w11d, p21) + cross(w11, cross(w11, p21)) + v11d);
vc22d = cross(w22d, pc22) + cross(w22, cross(w22, pc22)) + v22d;
F22 = m2*vc22d;
N22 = I2*w22d + cross(w22, I2*w22);
% i = 2 连杆3
w33 = R32*w22 + theta_d(3)*z;
w33d = R32*w22d + cross(R32*w22, z*theta_d(3)) + theta_dd(3)*z;
v33d = R32*(cross(w22d, p32) + cross(w22, cross(w22, p32)) + v22d);
vc33d = cross(w33d, pc33) + cross(w33, cross(w33, pc33)) + v33d;
F33 = m3*vc33d;
N33 = I3*w33d + cross(w33, I3*w33);

%%
f44 = [0; 0; 0]; n44 = [0; 0; 0];
% i = 3
f33 = R34*f44 + F33;
n33 = N33 + R34*n44 + cross(pc33, F33) + cross(p43, R34*f44);
tau(3) = n33'*z;
% i = 2
f22 = R23*f33 + F22;
n22 = N22 + R23*n33 + cross(pc22, F22) + cross(p32, R23*f33);
tau(2) = n22'*z;
% i =1
f11 = R12*f22 + F11;
n11 = N11 + R12*n22 + cross(pc11, F11) + cross(p21, R12*f22);
tau(1) = n11'*z;
end

function T = MDHTrans(alpha, a, d, theta)
T= [cos(theta)             -sin(theta)            0            a;
    sin(theta)*cos(alpha)  cos(theta)*cos(alpha)  -sin(alpha)  -sin(alpha)*d;
    sin(theta)*sin(alpha)  cos(theta)*sin(alpha)  cos(alpha)   cos(alpha)*d;
    0                      0                      0            1];
end
