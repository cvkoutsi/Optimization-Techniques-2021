clear 
clc 
close all 


mex slicmex.c 
imIn= imread('bee.jpg');

%% Turn original image to image of superpixels
[M,N,z] = size(imIn);
reqNumLabels = 400;
cFactor = 20;
[labels, ~] = slicmex(imIn, reqNumLabels, cFactor);

img = superpixelDescriptor(imIn, labels); %image of superpixels

%plot the original image and the image of superpixels
figure()
subplot(1,2,1)
imshow(imIn);
title('Original Image');
subplot(1,2,2)
imshow(img);
title('Image of superpixels');
%% Create input for Image2Graph
U = unique(reshape(img,[],3,1),'rows');
U = double(U);
W1 = Image2Graph(U,2);
l_W1 = length(W1);

%% Non Recursive Image clustering
k = 100;
clusterIdx = myGraphSpectralClustering(W1, k); %the initial image clustering that creates the first two clusters

C = zeros(M*N,1);

for i = 1:length(U)
    ind = find(img(:,:,1) == U(i,1) & img(:,:,2) == U(i,2));
    C(ind) = clusterIdx(i);
end

figure();
subplot(1,2,1)
imshow(img)
title('Original Image of superpixels');
a = label2rgb(C);
C = reshape(a,M,N,3);
subplot(1,2,2);
imshow(C);
title({['Non recursive n-cuts clustering']
    ['number of clusters = ',num2str(k)]});
%% Recursive Image clustering with T1 condition
T1 = 7;
k = 2;
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

C = zeros(M*N,1);

for i = 1:length(U)
    ind = find(img(:,:,1) == U(i,1) & img(:,:,2) == U(i,2));
    C(ind) = finalId(i);

end

figure();
subplot(1,2,1)
imshow(img)
title('Original Image of superpixels');
a = label2rgb(C);
C = reshape(a,M,N,3);
subplot(1,2,2)
imshow(C);
title({['N-cuts clustering with T1 = ', num2str(T1)]
    ['number of clusters = ',num2str(maxCluster)]});

%% Recursive Image clustering with T2 condition
T2 =1e-3;
k = 2;
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


C = zeros(M*N,1);

for i = 1:length(U)
    ind = find(img(:,:,1) == U(i,1) & img(:,:,2) == U(i,2));
    C(ind) = finalId(i);

end

figure();
subplot(1,2,1)
imshow(img)
title('Original Image of superpixels');
a = label2rgb(C);
C = reshape(a,M,N,3);
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
