clc,clear

% 2.32
syms th1 th3 L1 L2 L3
uTr=transl(L1,0,0);
A1=trotz(90+th1)*transl(0,0,0)*transl(0,0,0)*trotx(90,'deg');
A2=trotz(0)*transl(0,0,L2)*transl(0,0,0)*trotx(-90,'deg');
A3=trotz(th3)*transl(0,0,0)*transl(0,0,0)*trotx(90,'deg');
uTh=uTr*A1*A2*A3;
disp(uTh)

% 2.33
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

% 2.34
syms th1 th4 L1 L2 L3 L4 L5 L6 L7 L8
uTr=transl(L1,L2,L3);
A1=trotz(th1,'deg')*transl(0,0,L4)*transl(0,0,0)*trotx(-90,'deg');
A2=trotz(-90,'deg')*transl(0,0,L5)*transl(L6,0,0)*trotx(90,'deg');
A3=trotz(90,'deg')*transl(0,0,L7)*transl(0,0,0)*trotx(90,'deg');
A4=trotz(th4,'deg')*transl(0,0,L8)*transl(0,0,0)*trotx(0,'deg');
uTh=uTr*A1*A2*A3*A4;
disp(uTh)