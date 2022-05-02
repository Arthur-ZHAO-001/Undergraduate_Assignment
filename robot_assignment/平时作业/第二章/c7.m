clc;
clear;
close all
T2=[ 0.527   -0.574   0.628  ;
    0.369    0.819   0.439   ;
   -0.766    0       0.643  ];
eul=tr2eul(T2);
disp(round(eul/pi*180))

