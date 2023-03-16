%Optimization Teichniques- Exercise 1- Steepest Descent Method
%find min of function using standard ã

clear
clc

set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

syms x y
f = 0.5*x^2+2*y^2;
     
figure();
fcontour(f, [-10, 10, -10, 10])
colorbar
xlabel('x axis');
ylabel('y axis');
title ('Contour plot of f');
xlabel('x');
ylabel('y');
zlabel('z');
saveas(gcf,'contour_plot.png');

figure();
fsurf(f, [-10, 10, -10, 10]);
colorbar
title ('Plot of f');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
saveas(gcf,'plot.png');