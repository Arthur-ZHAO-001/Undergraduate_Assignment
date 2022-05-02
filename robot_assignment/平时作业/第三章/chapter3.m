%% 3.1
T1 = [0 0 1 2
       1 0 0 7
       0 1 0 5
       0 0 0 1];
suanzi = [0 -0.15 0 0.1
          0.15 0 0 0.1
          0 0 0 0.3
          0 0 0 0];
dT = suanzi*T1
T2 = T1+dT
print(T2)
%% 3.2
T = [1 0 0 5
     0 0 1 3
     0 -1 0 8
     0 0 0 1];
dT = [0 -0.1 -0.1 0.6
      0.1 0 0 0.5
      -0.1 0 0 -0.5
      0 0 0 0];
suanzi = dT*inv(T) %第一步计算微分算子 从而求出微分变化量
suanziT = inv(T)*dT %再计算相对于T坐标系的微分算子

%% 3.3 已知微分变化量为(1,0,0.5,0,0.1,0)
%a 则可以直接写出微分算子
suanzi = [0 0 0.1 1
          0 0 0 0
          -0.1 0 0 0.5
          0 0 0 0];
%b 相对于坐标系A的微分算子
A = [0 0 1 10
     1 0 0 5
     0 1 0 0
     0 0 0 1];
suanziA = inv(A)*suanzi*A

%% 3.4
%(a) 已知位姿T1,T2，求变换矩阵
T1 = [1 0 0 5
    0 0 -1 3
    0 1 0 6
    0 0 0 1];
T2 = [1 0 0.1 4.8
      0.1 0 -1 3.5
      0 1 0 6.2
      0 0 0 1];
Q =T2*inv(T1)
%(b)由微分算子定义可知，suanzi=Q-I
I = [1 0 0 0
     0 1 0 0 
     0 0 1 0
     0 0 0 1];
suanzi = Q-I
%(c)观察可得：d=[0.1,0,0.2] deta=[0,0,0.1]

%% 3.5
T = [0 1 0 10
     1 0 0 5
     0 0 -1 0
     0 0 0 1];
J = [8 0 0 0 0 0
     -3 0 1 0 0 0
     0 10 0 0 0 0
     0 1 0 0 1 0
     0 0 0 1 0 0
     -1 0 0 0 0 1];
D0 = [0;0.1;-0.1;0.2;0.2;0];
D = J*D0
% 由微分变化量D可推得算子suanzi
suanzi = [0 0 0.2 0
          0 0 -0.3 -0.1
          -0.2 0.3 0 1
          0 0 0 0];
dT = T*suanzi
T2 = T+dT
suanzi2 = T*suanzi*inv(T)

%% 3.10

clc;
clear;

time(1)=0.0;
qt=0.1;
n=50;
% %机器人参数
DR = pi/180;
% 构建机器人
L1=4;L2=3;L3=2;
alp(1)=0;a(1)=L1;d(1)=0;th(1)=90;
alp(2)=0;a(2)=L2;d(2)=0;th(2)=90;
alp(3)=0;a(3)=L3;d(3)=0;th(3)=90;
L(1)=Link([th(1),d(1),a(1),alp(1),0],'mod');
L(2)=Link([th(2),d(2),a(2),alp(2),0],'mod');
L(3)=Link([th(3),d(3),a(3),alp(3),0],'mod');
ThreeR =SerialLink(L,'name','Plan3R');
ThreeR.display()
% %初始角度值
theta = [10 20 30]'*DR;              % Initial angles
thetaall=transpose(theta);%存储theta矩阵
%初速度和力矩
v0=[0.2;-0.3;-0.2];
W0=[1 2 3]';
J1=zeros(3,3);
%计算雅可比矩阵
J1=Jacobian_Matlab_Exercise_5(theta);
disp(J1)
%计算thetadot,位置初始量
thetadot=inv(J1)*v0;
thetadotall=transpose(thetadot);%存储theta矩阵
%计算并存储T矩阵
T=ThreeR.fkine(transpose(theta));
pos=transl(T);
pos(3)=(theta(1)+theta(2)+theta(3))*180/pi;
%pos(3)=atan(pos(2)/pos(1))*180/pi;
posall=pos;%存储pos矩阵

Jdet(1)=det(J1);%存储J行列式
tau=transpose(J1)*W0;%计算初始转矩
tauall=transpose(tau);%存储tau矩阵

for i=1:50
    theta=theta+thetadot*qt;%更新角度
    thetaall=cat(1,thetaall,transpose(theta));%存储theta矩阵
    
    J=Jacobian_Matlab_Exercise_5(theta);%更新雅可比矩阵
    
    T=ThreeR.fkine(transpose(theta));
    pos=transl(T);
    pos(3)=(theta(1)+theta(2)+theta(3))*180/pi;
    posall=cat(1,posall,pos);%存储pos矩阵
    
    thetadot=inv(J)*v0;%更新角速度
    thetadotall=cat(1,thetadotall,transpose(thetadot));%存储theta矩阵
    
    Jdet(i+1)=det(J);%更新并存储雅可比行列式
    
    tau=transpose(J)*W0;%更新转矩
    tauall=cat(1,tauall,transpose(tau));%存储tau矩阵
    
    time(i+1)=time(i)+qt
end
Jdet=Jdet';
lasttime=time(51);
%%%最终输出矩阵T_last为
disp(T)