function [Jacobian]=Jacobian_Matlab_Exercise_5(theta);
%从mathematica的计算结果导入的Jacobian矩阵
%返回Jabobian矩阵
syms	C1	C2	C3	C4	C5	C6	real;
syms	S1	S2	S3	S4	S5	S6	real;
syms	C123	S123	C12	S12	C23	S23	real	;
syms	l1	l2	l3	;
J0=[C123*(S23*l1+S3*l2)-S123*(C23*l1+C3*l2+l3) C123*S3*l2-S123*(C3*l2+l3) -(S123*l3);
    S123*(S23*l1+S3*l2)+C123*(C23*l1+C3*l2+l3) S3*S123*l2+C123*(C3*l2+l3)   C123*l3;
    1 1 1];%%Jacobian来自mathematica的推导

Jacobian1=subs(J0,[	C1	;	C2	;	C3	]	,	[	cos(theta(1));	cos(theta(2));	cos(theta(3));	]);
Jacobian1=subs(Jacobian1,[	S1	;	S2	;	S3	]	,	[	sin(theta(1));	sin(theta(2));	sin(theta(3))	]);
Jacobian1=subs(Jacobian1,[	l1	;	l2	;	l3	]	,	[4;3;2]);
Jacobian=subs(Jacobian1,[	C123	;	S123	;	C12	;	S12	;	C23	;	S23	],[	cos(theta(1)+ theta(2)+ theta(3));	sin(theta(1)+ theta(2)+ theta(3));	cos(theta(1)+ theta(2));	sin(theta(1)+ theta(2));	cos(theta(2)+ theta(3));	sin(theta(2)+ theta(3))]);
Jacobian=eval(Jacobian);
