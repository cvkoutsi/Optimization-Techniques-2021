clear
clc
close all;

p1 = 772;
p2 = 772;
p = [p1,p2];
rhom=5;
rhoM=20;
rhostep=1;
N=8;

I = imread('TestIm1.png');
d = myLocalDescriptor(I,p,rhom,rhoM,rhostep ,N)´