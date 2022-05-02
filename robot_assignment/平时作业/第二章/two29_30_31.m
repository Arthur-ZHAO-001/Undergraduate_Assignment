%% 2.1
P = [1;2;3]
R1 = rotx(30,'deg')
R2 = roty(60,'deg')
P1= R2*R1*P
%% 2.2(1)
T_tot=trotz(90,'deg')*transl(5,3,6)*trotx(90,'deg')
p=T_tot*[5;3;4;1]

%% 2.2(2)
T_tot2=transl(5,3,6)*trotz(90,'deg')*trotx(90,'deg')
p2=T_tot2*[5;3;4;1]

%% 2.3
T1=[0.527 -0.574 0.628 2;0.369 0.819 0.439 5;-0.766 0 0.643 3;0 0 0 1];
disp(T1)
iT1=inv(T1)
T2=[0.92 0 0.39 5;0 1 0 6;-0.39 0 0.92 2;0 0 0 1];
iT2=inv(T2)







%% 2.29 
%令θ1=0，l1=5，l2=5，l3=5，l4=5，l5=5，l6=10
T1= [1 0 0 5
    0 1 0 5
    0 0 1 4
    0 0 0 1];
L1=Link([0,5,0,0,0]);
A1=[L1.A(0).n,L1.A(0).o,L1.A(0).a,L1.A(0).t;0 0 0 1]
L2=Link([0,0,5,-pi/2,1]);
A2=[L2.A(0).n,L2.A(0).o,L2.A(0).a,L2.A(0).t;0 0 0 1]
L3=Link([0,10,0,0,0]);
A3=[L3.A(pi/2).n,L3.A(pi/2).o,L3.A(pi/2).a,L3.A(pi/2).t;0 0 0 1]               %移动矩阵，参数为d

T = T1*A1*A2*A3 

%% 2.30 联立解方程
%由旋转方程中S12/C12得：θ1+θ2 = arctan(0.9563/-0.2924)=107°
%由位移方程中沿x、y方向位移联立方程组得：θ1 = arctan((0.8172-09563),(0.6978+0.2924))=-8°
%所以θ2 = 107-(-8)=115°

%% 2.31
%令θ1=0，θ2=90，θ3=0，d1=8，d2=2，d3=10，d4=10，d5=10
T1= [1 0 0 0
    0 1 0 0
    0 0 1 10
    0 0 0 1];
L1=Link([0,0,10,0,0]);
A1=[L1.A(0).n,L1.A(0).o,L1.A(0).a,L1.A(0).t;0 0 0 1]
L2=Link([0,0,10,pi,0]);
A2=[L2.A(pi/2).n,L2.A(pi/2).o,L2.A(pi/2).a,L2.A(pi/2).t;0 0 0 1]
L3=Link([0,10,0,0,0]);
A3=[L3.A(0).n,L3.A(0).o,L3.A(0).a,L3.A(0).t;0 0 0 1]

T = T1*A1*A2*A3

clc,clear

%% 2.32
syms th1 th3 L1 L2 L3
uTr=transl(L1,0,0);
A1=trotz(90+th1)*transl(0,0,0)*transl(0,0,0)*trotx(90,'deg');
A2=trotz(0)*transl(0,0,L2)*transl(0,0,0)*trotx(-90,'deg');
A3=trotz(th3)*transl(0,0,0)*transl(0,0,0)*trotx(90,'deg');
uTh=uTr*A1*A2*A3;
disp(uTh)

%% 2.33
th1=0; th2=45; th3=0; th4=0; th5=-45; th6=0;
d2=6; a2=15; a3=1; d4=18;
uTr=transl(0,0,0);
A1=trotz(90+th1,'deg')*transl(0,0,0)*transl(0,0,0)*trotx(-90,'deg');
A2=trotz(th2,'deg')*transl(0,0,d2)*transl(a2,0,0)*trotx(0,'deg');
A3=trotz(th3,'deg')*transl(0,0,0)*transl(a3,0,0)*trotx(-90,'deg');
A4=trotz(th4,'deg')*transl(0,0,d4)*transl(0,0,0)*trotx(90,'deg');
A5=trotz(th5,'deg')*transl(0,0,0)*transl(0,0,0)*trotx(-90,'deg');
A6=trotz(th6,'deg')*transl(0,0,0)*transl(0,0,0)*trotx(0,'deg');
uTh=uTr*A1*A2*A3*A4*A5*A6;
disp(uTh)

%% 2.34
syms th1 th4 L1 L2 L3 L4 L5 L6 L7 L8
uTr=transl(L1,L2,L3);
A1=trotz(th1,'deg')*transl(0,0,L4)*transl(0,0,0)*trotx(-90,'deg');
A2=trotz(-90,'deg')*transl(0,0,L5)*transl(L6,0,0)*trotx(90,'deg');
A3=trotz(90,'deg')*transl(0,0,L7)*transl(0,0,0)*trotx(90,'deg');
A4=trotz(th4,'deg')*transl(0,0,L8)*transl(0,0,0)*trotx(0,'deg');
uTh=uTr*A1*A2*A3*A4;
disp(uTh)