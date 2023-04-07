%Optimization Teichniques- Exercise 4- Levenberg-Marquardt Method
%find min of function using � found by Armijo rule

clear
clc

set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

x_start = [0 -1 1]';
y_start = [0 -1 1]';
epsilon = 0.01;
k = zeros(3,1);
min_estimate = zeros(3,1);

fprintf('Lavenberg Marquardt Method- Find gk using the Armijo rule\n');
for i = 1:3
    x = x_start(i);
    y = y_start(i);
    fprintf('Starting Point: [%d,%d]\n',x_start(i),y_start(i));
    
    d = - inv(hessianf(x,y))*gradf(x,y);
    gamma = armijo(x,y,d);
        
    gk = gamma;
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
        
        while det(A) <= 0 || A(1,1) <= 0 
            mk = mk + 0.1;
            A = hessianf(x,y) + mk.*eye(2);
        end   
        
        d = -inv(A)*gradf(x,y);
        gamma = armijo(x,y,d);
        
        check = criteria(x,y,d,gamma);
        if ~check
            fprintf('Criteria not fulfilled. Breakage point:[%f,%f] at repetition %d\n',x,y,k(i));
            break
        end
        
        x = x + d(1)*gamma;
        y = y + d(2)*gamma;
        
        plot(x,y,'ro');
        
        k(i) = k(i)+1
        x_estimate = [x_estimate; x];
        y_estimate = [y_estimate; y];     
        gk = [gk; gamma];
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
    
    figure(i+6)
    plot(1:k(i),gk,'r-*');
    title(['Gk for every repetition with starting point[' num2str(x_start(i)) ',' num2str(y_start(i)) ']']);
    xlabel('k');
    ylabel('gk');
    
    fprintf('Best minimum estimation: f(%f,%f) = %f\n',x_estimate(k(i)),y_estimate(k(i)),min_estimate(i));
end