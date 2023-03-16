%Optimization Teichniques- Exercise 1- Steepest Descent Method
%find min of function using standard ã

clear
clc

set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

 syms x y
 f = x^3*exp(-x^2 -y^4);
    
figure(1);
fcontour(f, [-3, 3, -3, 3])
colorbar
xlabel('x axis');
ylabel('y axis');
title ('Contour plot of f');

figure(2);
fsurf(f, [-3, 3, -3, 3]);
colorbar
title ('Plot of f');