clc;
clear;
close all
% 1
T=transl(0,6,0); 
R=trotx(pi/3);
T1=transl(0,0,3); 
R1=trotz(pi/3);
R2=trotx(pi/4);
A=R2*R1*T1*T*R;
disp(A)
% 2
eul=tr2eul(A);
disp(round(eul/pi*180,4))
