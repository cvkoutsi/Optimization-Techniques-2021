clear 
clc
close all;
rng(1)

load('dip_hw_2.mat');

clusterIdx = zeros(length(d1a),3);
k = [2,3,4];

for i = 1:length(k)
    clusterIdx(:,i) = myGraphSpectralClustering(d1a, k(i));
end

