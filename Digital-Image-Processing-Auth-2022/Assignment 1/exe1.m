clear 
clc 
close all;

img= imread('TestIm1.png');
imagerot = myImgRotation(img, 35);
figure()
imshow(imagerot);
saveas(gcf, "33.pdf");

imagerot = myImgRotation(img, 222);
figure()
imshow(imagerot);
saveas(gcf, "222.pdf");

