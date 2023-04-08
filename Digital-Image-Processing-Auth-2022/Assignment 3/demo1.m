clear 
clc
close all


channel_name = [" Red", " Green", " Blue"];
weightingFun_name = ["Uniform", "Tent", "Gaussian", "Photon"];

%% Set image directory
path_directory='Image1';
files=dir([path_directory '/*.jpg']);

filename=[path_directory '/' files(1).name];
img=imread(filename);
[M,N,~] = size(img);
imgStack = zeros(M,N,length(files));

%% Calculate radiance map
exposureTimes = [1/2500, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/8, 1/4, 1/2, 1, 2, 4, 8, 15];

for channel = 1:3
    for i=1:length(files)
        %Create image stack
        name = strcat('exposure',num2str(i),'.jpg');
        filename=[path_directory '/' name];
        img=double(imread(filename));
        img(img == 0) = 1e-2; %set zero values to 1e-2
        imgStack(:,:,i) = img(:,:,channel);
    end
   
    for weightingFcn = 1:4
        radianceMap = mergeLDRStack(imgStack, exposureTimes, weightingFcn);
        figure()
        imagesc(radianceMap);
        colorbar
        title(strcat('[',weightingFun_name(weightingFcn),' weighting function]: ',' Radiance map of',channel_name(channel),' channel'),'FontSize',15);

        figure()
        histogram(radianceMap);
        title(strcat('[',weightingFun_name(weightingFcn),' weighting function]: ',' Histogram of',channel_name(channel),' channel'),'FontSize',15);
    end
end

