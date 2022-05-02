clear
clc
%% 定义机械臂（一二问通用）
L1=Link([0 138 0 pi/2 0],'mod');
L(1).qlim=[-pi/2, pi/2];
L2=Link([0 0 135 0 0],'mod');L2.offset=-pi/4;
L3=Link([0 0 147 0 0],'mod');L3.offset=pi/2;
robot = SerialLink([L1,L2,L3], 'name' , '机器人');  
robot.base= transl(0 ,0 ,0);%建立模型
robot.display();  %显示建立的机器人的DH参数
space=500;
view(3)
robot.display();
%robot.plotopt = {'workspace',[-space,space,-2*space,space,-space,space],'tilesize',space};  %设置模型空间大小和地砖大小
robot.teach;       %画出模型并进行调控
%% 第一问
% T1=transl(200, 120, 40);%根据给定起始点，得到起始点位姿
% T2=transl(220,-150,220);%根据给定终止点，得到终止点位姿
% 
% t=[0:0.4:5]';
% Ts1=ctraj(T1,T2,length(t));
% q_s1=robot.ikine(Ts1,'mask',[1 1 1 0 0 0]);
% q = [q_s1]
% x=squeeze(Ts1(1,4,:)); y=squeeze(Ts1(2,4,:)); z=squeeze(Ts1(3,4,:));
% x2=[x];y2=[y];z2=[z];
% plot3(x2,y2,z2);
% robot.plot(q);%进行仿真
%% 第二问

% N = (0:0.5:100)'; 
% center = [175 0 5];
% radius = 50;
% theta = ( N/N(end) )*2*pi;
% points = (center + radius*[cos(theta) sin(theta) zeros(size(theta))])';  
% plot3(points(1,:),points(2,:),points(3,:),'r');
% 
% robot.plot([0 0 0]);%显示机器人初始状态
% 
% 
% T = transl(points');
% q = robot.ikine(T,'mask',[1 1 1 0 0 0]);
% hold on;
% robot.plot(q,'tilesize',300)
% % 
%% 第三问

N = (0:0.5:100)'; 
center = [180 10 5];
radius = 40;
theta = ( N/N(end) )*2*pi;
points = (center + radius*[cos(theta) sin(theta) zeros(size(theta))])';  
plot3(points(1,:),points(2,:),points(3,:),'r');

robot.plot([0 0 0]);%显示机器人初始状态


T = transl(points');
q = robot.ikine(T,'mask',[1 1 1 0 0 0]);
hold on;
robot.plot(q,'tilesize',300)
% % 



