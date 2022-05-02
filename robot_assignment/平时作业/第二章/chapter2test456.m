clc;clear;close all;
%% 2.4
% 答：绕o轴转-β角，绕a轴转-α角
%% 2.5

%(1)
syms r b g
eq1=r*sind(b)*cosd(g)-3.1375;
eq2=r*sind(b)*sind(g)-2.195;
eq3=r*cosd(b)-3.214;
s=vpasolve(eq1,eq2,eq3,r,b,g);
% 得到解
r = eval(s.r);
beta = eval(s.b);
gamma = eval(s.g);

%(2)
% 代入计算
T1 = [
    cosd(beta)*cosd(gamma) -sind(gamma) sind(beta)*cosd(gamma) r*sind(beta)*cosd(gamma)
    cosd(beta)*cosd(gamma) cosd(gamma) sind(beta)*sind(gamma) r*sind(beta)*sind(gamma)
    -sind(beta) 0 cosd(beta) r*cosd(beta)
    0 0 0 1
    ]

%% 2.6
format long g
T = [
    0.527 -0.574 0.628 4;
    0.369 0.819 0.439 6;
    -0.766 0 0.643 9;
    0 0 0 1
    ]
% 第一组解
Fa1 = atan2(T(2,1),T(1,1))*180/pi;;
Fo1 = atan2((-T(3,1)),(T(1,1)*cos(Fa1)+T(2,1)*sin(Fa1)))*180/pi;;
Fn1 = atan2((-T(2,3)*cos(Fa1)+T(1,3)*sin(Fa1)),(T(2,2)*cos(Fa1)-T(1,2)*sin(Fa1)))*180/pi;;
% 第二组解
Fa2 = atan2(-T(2,1),-T(1,1))*180/pi;;
Fo2 = atan2((-T(3,1)),(T(1,1)*cos(Fa2)+T(2,1)*sin(Fa2)))*180/pi;;
Fn2 = atan2((-T(2,3)*cos(Fa2)+T(1,3)*sin(Fa2)),(T(2,2)*cos(Fa2)-T(1,2)*sin(Fa2)))*180/pi;;
% 两组解
F1 = [Fa1,Fo1,Fn1]
F2 = [Fa2,Fo2,Fn2]