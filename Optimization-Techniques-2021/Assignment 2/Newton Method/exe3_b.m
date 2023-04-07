%Optimization Teichniques- Exercise 1- Newton Method
%find min of function using ã found by minimizing f using the golden
%section method

clear
clc

set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

x_start = [0 -1 1]';
y_start = [0 -1 1]';
epsilon = 0.001;
k = zeros(3,1);
min_estimate = zeros(3,1);

fprintf('Newton Method- Find gk using the golden section method\n');
for i = 1:3
    
    x = x_start(i);
    y = y_start(i);

    h = hessianf(x,y);
    if det(h) <= 0 || A(1,1) <= 0 
        fprintf('Starting point [%d, %d]: Hessian matrix is not positive infinitive. We cannot implement the Newton Method\n',x,y);
        continue;
    else
        fprintf('Starting Point: [%d,%d]\n',x_start(i),y_start(i));
    end
    
    syms g
    d = - inv(hessianf(x,y))*gradf(x,y);
    h(g) = f(x + g*d(1), y + g+d(2),2);

    %find g using the golden section method
    lambda = 0.01;
    a = 0;
    b = 5;
    [gamma, ~, ~, ~, ~] = golden_section(h, lambda, a, b);
    
    gk = gamma;
    x_estimate =x;
    y_estimate = y;
    
    k(i) = 1;
    
    figure(i);
    fsurf(f(x,y,1), [-4, 4, -4, 4]);
    colorbar
    hold on;
    plot(x,y,'ro');
    
    syms g
    while norm(gradf(x,y)) > epsilon   
        d = - inv(hessianf(x,y))*gradf(x,y);
        h(g) = f(x + g*d(1), y + g+d(2),2);
        
        %find g using the golden section method
        lambda = 0.01;
        a = 0;
        b = 5;
        [gamma, ~, ~, ~, ~] = golden_section(h, lambda, a, b);
        
        x = x + d(1)*gamma;
        y = y + d(2)*gamma;
        
        plot(x,y,'ro');
        
        k(i) = k(i)+1
        x_estimate = [x_estimate; x];
        y_estimate = [y_estimate; y];  
        gk = [gk; gamma];
    end
    hold off;
    title(['Minimum estimation with starting point [' num2str(x_start(i)) ',' num2str(y_start(i)) ']']);
    min_estimate(i) = f(x,y,2);
    
    figure(i+3)
    plot3(1:k(i), x_estimate,y_estimate,'-*');
    title(['Minimum point with starting point [' num2str(x_start(i)) ',' num2str(y_start(i)) ']']);
    xlabel('k');
    ylabel('x');
    zlabel('y');
    
    figure(i+6)
    plot(1:k(i),gk,'r-*');
    title(['Gk for every repetition with starting point[' num2str(x_start(i)) ',' num2str(y_start(i)) ']']);
    xlabel('k');
    ylabel('gk');    
    
    fprintf('Best minimum estimation: f(%f,%f) = %f after %d repetitions\n',x_estimate(k(i)),y_estimate(k(i)),min_estimate(i),k(i));
end