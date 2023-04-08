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

%% Recursive Image clustering with T1 condition 
T1 = 5;
k = 2;

l_img = length(img);
W1 = Image2Graph(img,1); %turn image to graph
l_W1 = length(W1);

finalId = zeros(l_W1,1); %initialize array that will store the final cluster id for each pixel
clusterIdx = myGraphSpectralClustering(W1, k); %the initial image clustering that creates the first two clusters
finalId(:) = clusterIdx(:);
cluster = [1 2]; %vector that stores the clusters and is dynamically changed with each iteration
maxCluster = 2; %the maximum cluster. After the first image clustering it is equal to 2

i = 1;
while i <= length(cluster) %this loop runs for each cluster and divides it into more clusters if the condition is met
    k1 = find(finalId == cluster(i)); %finds the position of the pixels that belong to this cluster
    k2 = find(finalId > cluster(i)); %finds the position of the pixels that do not belong to this cluster
    A = W1(k1,k1);

    while length(A) > T1

        clusterIdx = myGraphSpectralClustering(A, k);

        k1_temp = find(clusterIdx == 1);
        k2_temp = find(clusterIdx == 2);

        finalId(k1(k1_temp)) = finalId(k1(k1_temp));
        finalId(k1(k2_temp)) = finalId(k1(k2_temp)) + 1; 
        finalId(k2) = finalId(k2) + 1;
        maxCluster = maxCluster + 1;
        cluster = [cluster maxCluster];
       
        k1 = find(finalId == cluster(i));
        k2 = find(finalId > cluster(i));
        A = W1(k1,k1); 
    end
    i = i+1;
end
figure()
subplot(1,2,1)
imshow(img)
title('Original Image');
a = label2rgb(finalId);
C = reshape(a,l_img,l_img,3);
subplot(1,2,2)
imshow(C);
title({['N-cuts clustering with T1 = ', num2str(T1)]
    ['number of clusters = ',num2str(maxCluster)]});

%% Recursive Image clustering with T2 condition
T2 = 1;

finalId = zeros(l_W1,1);
clusterIdx = myGraphSpectralClustering(W1, k);
finalId(:) = clusterIdx(:);
cluster = [1 2];
maxCluster = 2;

i = 1;
while i <= length(cluster)
    k1 = find(finalId == cluster(i));
    k2 = find(finalId > cluster(i));
    
    A = W1(k1,k1);

    while condition(A,T2)
        clusterIdx = myGraphSpectralClustering(A, k);
        
        k1_temp = find(clusterIdx == 1);
        k2_temp = find(clusterIdx == 2);

        finalId(k1(k1_temp)) = finalId(k1(k1_temp));
        finalId(k1(k2_temp)) = finalId(k1(k2_temp)) +1;
        finalId(k2) = finalId(k2) + 1;
        maxCluster = maxCluster +1;
        cluster = [cluster maxCluster];
       
        k1 = find(finalId == cluster(i));
        k2 = find(finalId > cluster(i));
        A = W1(k1,k1);
    end
    i = i+1;
end

figure()
subplot(1,2,1)
imshow(img)
title('Original Image');
a = label2rgb(finalId);
C = reshape(a,l_img,l_img,3);
subplot(1,2,2)
imshow(C);
title({['N-cuts clustering with T2 = ', num2str(T2)]
    ['number of clusters = ',num2str(maxCluster)]});
%% Function that checks if the T2 condition is met 
function check = condition(A,T2)
    %check if the cluster only contains 1 pixel 
    if length(A) == 1
        check = false;
    else
        clusterIdx = myGraphSpectralClustering(A, 2);
        if calculateNcut(A,clusterIdx) < T2
            check = true;
        else
            check = false;
        end
    end
     
end

