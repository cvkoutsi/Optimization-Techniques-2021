clear;
clc;
close all; 

Gp = zpk([], [-1 -9],10);
Gc = zpk(-3 , 0 , 2);

controlSystemDesigner(Gp,Gc);
Kp = 2.224;
Ki = 2.886752;
c = Ki/Kp; 

Gc = zpk(-c,0,Kp);

open_loop_sys = series(Gp,Gc); %open loop tf
close_loop_sys = feedback(open_loop_sys,1,-1); %close loop feedback
step(close_loop_sys) %step response