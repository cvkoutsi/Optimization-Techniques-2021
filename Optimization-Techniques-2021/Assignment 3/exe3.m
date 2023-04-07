%Optimization Teichniques- Exercise 2- Steepest Descent Method with
%projection

syms x y 

f = 0.5*x^2+2*y^2;
gradf = jacobian(f,[x,y]);

sk = 10;
epsilon = 0.02;
gamma = 0.3;
x_start = -7;
y_start = 5;
a1 = -15;
b1 = 15;
a2 = -20;
b2 = 12;

fprintf('------------------------Steepest Descent Method with projection------------------------\n\n');

fprintf('Exercise 3\n'); 
fprintf('Starting Point = [%d,%d]\nGamma = %f\nsk = %d\nEpsilon = %f\n',x_start,y_start,gamma,sk,epsilon);
[x,y,k,min] = steepest_descent_projection(f,gradf,x_start,y_start,epsilon,gamma,sk,a1,a2,b1,b2);

