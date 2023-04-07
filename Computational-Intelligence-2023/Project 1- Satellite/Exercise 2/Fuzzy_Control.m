clear;
clc;
close all;

FLC = readfis('FLC.fis');

% 3d surface of the FLC
gensurf(FLC)