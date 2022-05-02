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
suanzi = dT*inv(T) %��һ������΢������ �Ӷ����΢�ֱ仯��
suanziT = inv(T)*dT %�ټ��������T����ϵ��΢������

%% 3.3 ��֪΢�ֱ仯��Ϊ(1,0,0.5,0,0.1,0)
%a �����ֱ��д��΢������
suanzi = [0 0 0.1 1
          0 0 0 0
          -0.1 0 0 0.5
          0 0 0 0];
%b ���������ϵA��΢������
A = [0 0 1 10
     1 0 0 5
     0 1 0 0
     0 0 0 1];
suanziA = inv(A)*suanzi*A

%% 3.4
%(a) ��֪λ��T1,T2����任����
T1 = [1 0 0 5
    0 0 -1 3
    0 1 0 6
    0 0 0 1];
T2 = [1 0 0.1 4.8
      0.1 0 -1 3.5
      0 1 0 6.2
      0 0 0 1];
Q =T2*inv(T1)
%(b)��΢�����Ӷ����֪��suanzi=Q-I
I = [1 0 0 0
     0 1 0 0 
     0 0 1 0
     0 0 0 1];
suanzi = Q-I
%(c)�۲�ɵã�d=[0.1,0,0.2] deta=[0,0,0.1]

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
% ��΢�ֱ仯��D���Ƶ�����suanzi
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
% %�����˲���
DR = pi/180;
% ����������
L1=4;L2=3;L3=2;
alp(1)=0;a(1)=L1;d(1)=0;th(1)=90;
alp(2)=0;a(2)=L2;d(2)=0;th(2)=90;
alp(3)=0;a(3)=L3;d(3)=0;th(3)=90;
L(1)=Link([th(1),d(1),a(1),alp(1),0],'mod');
L(2)=Link([th(2),d(2),a(2),alp(2),0],'mod');
L(3)=Link([th(3),d(3),a(3),alp(3),0],'mod');
ThreeR =SerialLink(L,'name','Plan3R');
ThreeR.display()
% %��ʼ�Ƕ�ֵ
theta = [10 20 30]'*DR;              % Initial angles
thetaall=transpose(theta);%�洢theta����
%���ٶȺ�����
v0=[0.2;-0.3;-0.2];
W0=[1 2 3]';
J1=zeros(3,3);
%�����ſɱȾ���
J1=Jacobian_Matlab_Exercise_5(theta);
disp(J1)
%����thetadot,λ�ó�ʼ��
thetadot=inv(J1)*v0;
thetadotall=transpose(thetadot);%�洢theta����
%���㲢�洢T����
T=ThreeR.fkine(transpose(theta));
pos=transl(T);
pos(3)=(theta(1)+theta(2)+theta(3))*180/pi;
%pos(3)=atan(pos(2)/pos(1))*180/pi;
posall=pos;%�洢pos����

Jdet(1)=det(J1);%�洢J����ʽ
tau=transpose(J1)*W0;%�����ʼת��
tauall=transpose(tau);%�洢tau����

for i=1:50
    theta=theta+thetadot*qt;%���½Ƕ�
    thetaall=cat(1,thetaall,transpose(theta));%�洢theta����
    
    J=Jacobian_Matlab_Exercise_5(theta);%�����ſɱȾ���
    
    T=ThreeR.fkine(transpose(theta));
    pos=transl(T);
    pos(3)=(theta(1)+theta(2)+theta(3))*180/pi;
    posall=cat(1,posall,pos);%�洢pos����
    
    thetadot=inv(J)*v0;%���½��ٶ�
    thetadotall=cat(1,thetadotall,transpose(thetadot));%�洢theta����
    
    Jdet(i+1)=det(J);%���²��洢�ſɱ�����ʽ
    
    tau=transpose(J)*W0;%����ת��
    tauall=cat(1,tauall,transpose(tau));%�洢tau����
    
    time(i+1)=time(i)+qt
end
Jdet=Jdet';
lasttime=time(51);
%%%�����������T_lastΪ
disp(T)