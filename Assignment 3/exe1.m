%Optimization Teichniques- Exercise 1- Steepest Descent Method
%find min of function using standard ã

syms x y 

f = 0.5*x^2+2*y^2;
gradf = jacobian(f,[x,y]);

epsilon = 0.01;
gamma = [0.05,0.5,2,10];
x_start = -1;
y_start = -1;

fprintf('------------------------Steepest Descent Method------------------------\n\n');

for i = 1:4
    fprintf('Exercise 1.%d\n',i); 
    fprintf('Starting Point = [%d,%d]\nGamma = %f\nEpsilon = %f\n\n',x_start,y_start,gamma(i),epsilon);
    [x,y,k,min] = steepest_descent(f,gradf,x_start,y_start,epsilon,gamma(i));   
end

