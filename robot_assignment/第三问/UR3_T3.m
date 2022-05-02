clear
clc
%%

% 代码思路: 
1.建立UR3模型
2.确定空间中求的位置与坐标
3.利用多段弧形轨迹连接成 ‘山大’
%利用第一问中DH参数建立UR3模型
L1=Link([0 151.9 0 pi/2 0]);L1.offset=pi/2;
L2=Link([0 86.85 -243.65 0 0]);L2.offset=pi/2;
L3=Link([0 -92.85 -213 0 0]);
L4=Link([0 83.4 0 pi/2 0]);L4.offset=pi/2;
L5=Link([0 83.4 0 -pi/2 0]);L5.offset=pi/2;
L6=Link([0 83.4 0 0 0]);
robot = SerialLink([L1,L2,L3,L4,L5,L6], 'name' , 'UR3');  
robot.base= transl(0 ,0 ,-300);%机械臂中心位置
robot.display();  %显示建立的机器人的DH参数
h=1000;
robot.plotopt = {'workspace',[-h,h,-2*h,h,-h,h],'tilesize',h};  %设置显示空间大小
view(3)
%robot.teach;   %显示模型
%%
hold on;
%画球
%球得圆心位置
x=0;y=-750;z=0;
%球的半径
r=300;
%画球
h1 = drawball(r,x,y,z,1000);
hold on;
%设定球颜色
h1.EdgeColor = [1,0.5,0];% RGB三原色
h1.FaceColor = [1,0.5,0];
%定义轨迹线
%%%%
对每条轨迹
步骤为：1.生成轨迹点的坐标 2.逆运动学求解 3.绘制仿真
% 山 左边的竖
% 山 左边的竖
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=-10:1:10 %生成圆弧的坐标
ang_2=deg2rad(30);%左右角度1
ang_1=deg2rad(ang_1);%上下角度2
z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.')
end
q=[x_array y_arrat z_array];
for i=length(q):-1:1
T(:,:,length(q)+1-i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikcon(T);
robot.plot(q1)
%%
% 山 横笔画
x_array=[];
y_arrat=[];
z_array=[];
for ang_2=30:-1:5
ang_2=deg2rad(ang_2);%左右角度1
ang_1=deg2rad(-10);%上下角度2
z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.')
end
q=[];T=[];q1=[];
q=[x_array y_arrat z_array];
for i=1:length(q)
T(:,:,i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikcon(T);
robot.plot(q1)
%%
% 山 中间的竖
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=-10:1:10 
ang_2=deg2rad(5);%左右角度1
ang_1=deg2rad(ang_1);%上下角度2

z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);%生成点坐标序列
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.')
end
q=[];T=[];q1=[];
q=[x_array y_arrat z_array];
for i=1:length(q)
T(:,:,i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikcon(T);
robot.plot(q1)
%%
% 山字 右边的竖
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=-10:1:20
ang_2=deg2rad(17.5);%左右角度1
ang_1=deg2rad(ang_1);%上下角度2

z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.')
end
q=[];T=[];q1=[];
q=[x_array y_arrat z_array];
for i=1:length(q)
T(:,:,i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikcon(T);
robot.plot(q1)
%%
% 大字  横笔画
x_array=[];
y_arrat=[];
z_array=[];
for ang_2=-5:-1:-30
ang_2=deg2rad(ang_2);%左右角度1
ang_1=deg2rad(6);%上下角度2

z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.')
end
q=[];T=[];q1=[];
q=[x_array y_arrat z_array];
for i=1:length(q)
T(:,:,i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikunc(T);
robot.plot(q1)
%%
% 大字撇 第一笔
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=6:1:20
ang_2=deg2rad(-19);%左右角度1
ang_1=deg2rad(ang_1);%上下角度2
z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.')
end
q=[x_array y_arrat z_array];
for i=length(q):-1:1
T(:,:,length(q)+1-i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikcon(T);
robot.plot(q1)



%%
%大字 撇 第二笔
x_array=[];
y_arrat=[];
z_array=[];
cq1=linspace(deg2rad(-6),deg2rad(-20),17);
for ang_1=-10:1:6
ang_2=cq1(ang_1+11);%左右角度1
ang_1=deg2rad(ang_1);%上下角度2
z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.');
end
q=[];T=[];q1=[];
q=[x_array y_arrat z_array];
for i=1:length(q)
T(:,:,i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikcon(T);
robot.plot(q1)
%%
%大字 捺 第一笔
x_array=[];
y_arrat=[];
z_array=[];
cq1=linspace(deg2rad(-25),deg2rad(-17.5),12);
for ang_1=-5:1:6 % 路径角度范围

ang_2=cq1(ang_1+6);
ang_1=deg2rad(ang_1);%上下角度2

z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.');
end
q=[];T=[];q1=[];
q=[x_array y_arrat z_array];
for i=1:length(q)
T(:,:,i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikunc(T);
robot.plot(q1)
%%
%大字 捺 第二笔
x_array=[];
y_arrat=[];
z_array=[];
cq1=linspace(deg2rad(-35),deg2rad(-25),7);
for ang_1=-11:1:-5
%左右角度1
ang_2=cq1(ang_1+12);
ang_1=deg2rad(ang_1);%上下角度2

z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);
x_array=[x_array;x_path];
y_arrat=[y_arrat;y_path];
z_array=[z_array;z_path];
plot3(x_path,y_path,z_path,'b.');
end
q=[];T=[];q1=[];
q=[x_array y_arrat z_array];
for i=1:length(q)
T(:,:,i)=transl(q(i,:))*trotx(pi/2);
end
q1=robot.ikunc(T);
robot.plot(q1)
%%
%恢复机械臂位置 使山大清晰可见
qz=[pi/2,pi/2,0,pi/2,pi/2,0];           %初始位置关节点参数

robot.plot(qz)         
%% 画球的函数
function h = drawball(r, centerx, centery, centerz, N)

if nargin == 5
    [x,y,z] = sphere(N);
else
    [x,y,z] = sphere(50);
end
h = surf(r*x+centerx, r*y+centery, r*z+centerz);
h.EdgeColor = rand(1,3);
h.FaceColor = h.EdgeColor;
end