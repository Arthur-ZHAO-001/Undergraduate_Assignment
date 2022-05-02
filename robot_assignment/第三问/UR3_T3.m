clear
clc
%%

% ����˼·: 
1.����UR3ģ��
2.ȷ���ռ������λ��������
3.���ö�λ��ι켣���ӳ� ��ɽ��
%���õ�һ����DH��������UR3ģ��
L1=Link([0 151.9 0 pi/2 0]);L1.offset=pi/2;
L2=Link([0 86.85 -243.65 0 0]);L2.offset=pi/2;
L3=Link([0 -92.85 -213 0 0]);
L4=Link([0 83.4 0 pi/2 0]);L4.offset=pi/2;
L5=Link([0 83.4 0 -pi/2 0]);L5.offset=pi/2;
L6=Link([0 83.4 0 0 0]);
robot = SerialLink([L1,L2,L3,L4,L5,L6], 'name' , 'UR3');  
robot.base= transl(0 ,0 ,-300);%��е������λ��
robot.display();  %��ʾ�����Ļ����˵�DH����
h=1000;
robot.plotopt = {'workspace',[-h,h,-2*h,h,-h,h],'tilesize',h};  %������ʾ�ռ��С
view(3)
%robot.teach;   %��ʾģ��
%%
hold on;
%����
%���Բ��λ��
x=0;y=-750;z=0;
%��İ뾶
r=300;
%����
h1 = drawball(r,x,y,z,1000);
hold on;
%�趨����ɫ
h1.EdgeColor = [1,0.5,0];% RGB��ԭɫ
h1.FaceColor = [1,0.5,0];
%����켣��
%%%%
��ÿ���켣
����Ϊ��1.���ɹ켣������� 2.���˶�ѧ��� 3.���Ʒ���
% ɽ ��ߵ���
% ɽ ��ߵ���
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=-10:1:10 %����Բ��������
ang_2=deg2rad(30);%���ҽǶ�1
ang_1=deg2rad(ang_1);%���½Ƕ�2
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
% ɽ ��ʻ�
x_array=[];
y_arrat=[];
z_array=[];
for ang_2=30:-1:5
ang_2=deg2rad(ang_2);%���ҽǶ�1
ang_1=deg2rad(-10);%���½Ƕ�2
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
% ɽ �м����
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=-10:1:10 
ang_2=deg2rad(5);%���ҽǶ�1
ang_1=deg2rad(ang_1);%���½Ƕ�2

z_path=z+r*sin(ang_1);
y_path=y+r*cos(ang_1)*cos(ang_2);
x_path=x+r*cos(ang_1)*sin(ang_2);%���ɵ���������
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
% ɽ�� �ұߵ���
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=-10:1:20
ang_2=deg2rad(17.5);%���ҽǶ�1
ang_1=deg2rad(ang_1);%���½Ƕ�2

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
% ����  ��ʻ�
x_array=[];
y_arrat=[];
z_array=[];
for ang_2=-5:-1:-30
ang_2=deg2rad(ang_2);%���ҽǶ�1
ang_1=deg2rad(6);%���½Ƕ�2

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
% ����Ʋ ��һ��
x_array=[];
y_arrat=[];
z_array=[];
for ang_1=6:1:20
ang_2=deg2rad(-19);%���ҽǶ�1
ang_1=deg2rad(ang_1);%���½Ƕ�2
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
%���� Ʋ �ڶ���
x_array=[];
y_arrat=[];
z_array=[];
cq1=linspace(deg2rad(-6),deg2rad(-20),17);
for ang_1=-10:1:6
ang_2=cq1(ang_1+11);%���ҽǶ�1
ang_1=deg2rad(ang_1);%���½Ƕ�2
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
%���� �� ��һ��
x_array=[];
y_arrat=[];
z_array=[];
cq1=linspace(deg2rad(-25),deg2rad(-17.5),12);
for ang_1=-5:1:6 % ·���Ƕȷ�Χ

ang_2=cq1(ang_1+6);
ang_1=deg2rad(ang_1);%���½Ƕ�2

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
%���� �� �ڶ���
x_array=[];
y_arrat=[];
z_array=[];
cq1=linspace(deg2rad(-35),deg2rad(-25),7);
for ang_1=-11:1:-5
%���ҽǶ�1
ang_2=cq1(ang_1+12);
ang_1=deg2rad(ang_1);%���½Ƕ�2

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
%�ָ���е��λ�� ʹɽ�������ɼ�
qz=[pi/2,pi/2,0,pi/2,pi/2,0];           %��ʼλ�ùؽڵ����

robot.plot(qz)         
%% ����ĺ���
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