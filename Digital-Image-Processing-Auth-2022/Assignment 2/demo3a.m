clear 
clc
close all;
rng(1)

%% Load images from file dip_hw_2.mat
load('dip_hw_2.mat');

%% Get the choice of image from user
while(1)
    prompt = input("Choose image (d2a or d2b)\n","s");
    if prompt == "d2a"
        img = d2a;
        break;
    elseif prompt == "d2b"
        img = d2b;
        break;
    else
        disp("Error. Please choose image d2a or d2b")
    end
end
%% Image clustering for k = 2
k = 2;

l = length(img);
W1 = Image2Graph(img,1); %turn image to graph

clusterIdx = myGraphSpectralClustering(W1, k);
nCutValue = calculateNcut(W1, clusterIdx);
disp(['Image ',prompt, ': nCut = ', num2str(nCutValue)])

a = label2rgb(clusterIdx);
C = reshape(a,l,l,3);

figure(1)
subplot(1,2,1)
imshow(img)
title('Original Image');
subplot(1,2,2)
imshow(C)
title({['Image clustering with k = ', num2str(k)]
    ['n-cut value: ',num2str(nCutValue)]});
