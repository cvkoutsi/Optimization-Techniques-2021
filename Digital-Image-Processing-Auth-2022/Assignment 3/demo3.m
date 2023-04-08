clear 
clc
close all

%% Find response curve of Image 1
channel_name = ["Red", "Green", "Blue"];

B = [1/2500, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/8, 1/4, 1/2, 1, 2, 4, 8, 15];
M = 20;
N = 20;
l = 200;

%set image directory
path_directory=strcat('Image1');
files=dir([path_directory '/*.jpg']);
Z = zeros(M*N,length(files));

for channel = 1:3
    for i=1:length(files)
        %Create image stack
        name = strcat('exposure',num2str(i),'.jpg');
        filename=[path_directory '/' name];
        img=(imread(filename)); 
        img= double(img(:,:,channel));
        
        %Downsample image
        img= reshape(img,[],1);
        step =round(size(img,1)/(M*N));
        Z(:,i) = img(1:step:size(img,1));
    end
    colors = ['r','g','b'];
    g = estimateResponseCurve(Z, B, l, 3);
    
    figure()
    plot(g,1:length(g), colors(channel));
    title(strcat('[Image 1]  ' ,channel_name(channel),' channel response function'),'FontSize',15);
    xlabel('Pixel value');
    ylabel('log(E*t)');
end

%% Image 2
B = [1/400, 1/250, 1/100, 1/40, 1/25, 1/8, 1/3];
M = 20;
N = 20;
l = 200;

%set image directory
path_directory=strcat('Image2');
files=dir([path_directory '/*.jpg']);
Z = zeros(M*N,length(files));

for channel = 1:3
    for i=0:length(files)-1
        %Create image stack
        if i ~=5
            name = strcat('sample2-0',num2str(i),'.jpg');
        else
            name = strcat('sample2-0',num2str(i),'_rotated.jpg');
        end
        filename=[path_directory '/' name];
        img=(imread(filename)); 
        img= double(img(:,:,channel));
                
        %Downsample image
        img= reshape(img,[],1);
        step =round(size(img,1)/(M*N));
        Z(:,i+1) = img(1:step:size(img,1));
    end
    colors = ['r','g','b'];
    g = estimateResponseCurve(Z, B, l, 2);
    
    figure()
    plot(g,1:length(g), colors(channel));
    title(strcat('[Image 2]  ' ,channel_name(channel),' channel response function'),'FontSize',15);
    xlabel('Pixel value');
    ylabel('log(E*t)');
end


