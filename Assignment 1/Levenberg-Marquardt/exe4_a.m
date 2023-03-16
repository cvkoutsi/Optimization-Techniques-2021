%Optimization Teichniques- Exercise 4- Levenberg-Marquardt
%find min of function using standard ã

clear
clc

set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

x_start = [0 -1 1]';
y_start = [0 -1 1]';
epsilon = 0.01;
gamma = 0.01;
k = zeros(3,1);
min_estimate = zeros(3,1);

fprintf('Lavenberg Marquardt Method- Constant gk\n');
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
        %choose mk
        mk = abs(max(eig(hessianf(x,y))));
        A = hessianf(x,y) + mk.*eye(2);
        
        while det(A) <= 0 || A(2,2) <= 0 
            mk = mk + 0.1;
            A = hessianf(x,y) + mk.*eye(2);
        end   
        
        d = -inv(A)*gradf(x,y);
        
        check = criteria(x,y,d,gamma);
        if ~check
            fprintf('Criteria not fulfilled. Breakage point:[%f,%f] at repetition %d\n',x,y,k(i));
            break
        end
        
        x = x + gamma*d(1);
        y = y + gamma*d(2);
        
        plot(x,y,'ro');
        
        k(i) = k(i)+1;
        x_estimate = [x_estimate; x];
        y_estimate = [y_estimate; y];        
    end
    min_estimate(i) = f(x,y,2);
    hold off;
    title(['Minimum estimation with starting point [' num2str(x_start(i)) ',' num2str(y_start(i)) ']']);
      
    figure(i+3)
    plot3(1:k(i), x_estimate,y_estimate,'-*');
    title(['Minimum point with starting point [' num2str(x_start(i)) ',' num2str(y_start(i)) ']']);
    xlabel('k');
    ylabel('x');
    zlabel('y');
    
    fprintf('Best minimum estimation: f(%f,%f) = %f\n',x_estimate(k(i)),y_estimate(k(i)),min_estimate(i));
end
