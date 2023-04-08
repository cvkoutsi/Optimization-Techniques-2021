clear 
clc
close all

%% Set image directory
path_directory='Image1';
files=dir([path_directory '/*.jpg']);

filename=[path_directory '/' files(1).name];
img=imread(filename);
[M,N,~] = size(img);
imgStack = zeros(M,N,length(files));

exposureTimes = [1/2500, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/8, 1/4, 1/2, 1, 2, 4, 8, 15];

%% Calculate toned Image
gamma = 1.4;
tonedImage = uint8(zeros(M,N,3));
for weightingFcn = 1:4
    for channel = 1:3
        for i=1:length(files)
            %Create image stack
            name = strcat('exposure',num2str(i),'.jpg');
            filename=[path_directory '/' name];
            img=double(imread(filename));
            img(img == 0) = 1e-2; %set zero values to 1e-2
            imgStack(:,:,i) = img(:,:,channel);
        end
        radianceMap = mergeLDRStack(imgStack, exposureTimes, weightingFcn);
        tonedImage(:,:,channel) = toneMapping(radianceMap, gamma);
    end
    figure()
    imshow(tonedImage);
end

%% Find optimal gamma 
gamma = [0.5 0.8 1.2 1.5]; %gammas to be tested
weightingFcn = 1; %uniform weighting function will be used
tonedImage = uint8(zeros(M,N,3));
untonedImage = uint8(zeros(M,N,3));
for g = 1:length(gamma)
    figure()
    for channel = 1:3
        for i=1:length(files)
            name = strcat('exposure',num2str(i),'.jpg');
            filename=[path_directory '/' name];
            img=double(imread(filename));
            img(img == 0) = 1e-2;
            imgStack(:,:,i) = img(:,:,channel);
        end
        radianceMap = mergeLDRStack(imgStack, exposureTimes, weightingFcn);
        tonedImage(:,:,channel) = toneMapping(radianceMap, gamma(g));
        untonedImage(:,:,channel) = toneMapping(radianceMap, 1);
    end
    
    % coordinates of pixels of interest, found with image viewer app
    coordinates = [1330 244; 1330 299; 1330 347; 1330 400; 1330 465; 1330 513]; 
    ind = sub2ind([M N], coordinates(:,2),coordinates(:,1));
    
    %turn toned image to gray image
    gray_tonedImg = rgb2gray(tonedImage);
    toned_pixels = double(gray_tonedImg(ind)); %value of pixels of interest in gray image
        
    %turn untoned image to gray image
    gray_untonedImg = rgb2gray(untonedImage);
    untoned_pixels = double(gray_untonedImg(ind)); %value of pixels of interest in gray image

    subplot(1,2,1)
    hold on;
    plot([1 6], [toned_pixels(1) toned_pixels(6)],'r-');
    plot(1:6,toned_pixels,'b-*');
    legend('Linear curve','Radiance of toned pixels','FontSize',12);
    hold off;
    title(strcat('[gamma = ',num2str(gamma(g)),'] Toned Image'),'FontSize',15);
    ylabel('Radiance of pixel');
    xlabel('Number of pixel');
    
    subplot(1,2,2)
    hold on;
    plot([1 6], [untoned_pixels(1) untoned_pixels(6)],'r-');
    plot(1:6,untoned_pixels,'b-*');
    legend('Linear curve','Radiance of untoned pixels','FontSize',12);
    hold off;
    title('Utoned Image','FontSize',15);
    ylabel('Radiance of pixel');
    xlabel('Number of pixel');
end

