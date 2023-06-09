%Optimization Teichniques- Exercise 1- Steepest Descent Method
%find min of function using standard �

clear
clc

set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

x_start = [0 -1 1]';
y_start = [0 -1 1]';
epsilon = 0.01;
gamma = 0.1;
k = zeros(3,1);
min_estimate = zeros(3,1);

fprintf('Steepest Descent Method- Constant gk\n');
for i = 1:3
    x = x_start(i);
    y = y_start(i);
    fprintf('Starting Point: [%d,%d]\n',x_start(i),y_start(i));
    
    x_estimate =x;
    y_estimate = y;
    
    k(i) = 1;
    
    figure(i);
    fsurf(f(x,y,1), [-4, 4, -4, 4]);
    colorbar
    hold on;
    plot(x,y,'ro');
    
    while norm(gradf(x,y)) > epsilon
        d = - gradf(x,y);
        x = x + d(1)*gamma;
        y = y + d(2)*gamma;
        
        plot(x,y,'ro');

        k(i) = k(i)+1;
        x_estimate = [x_estimate; x];
        y_estimate = [y_estimate; y];
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
    
    fprintf('Best minimum estimation: f(%f,%f) = %f after %d repetitions\n',x_estimate(k(i)),y_estimate(k(i)),min_estimate(i),k(i));
end

