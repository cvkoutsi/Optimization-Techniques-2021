function [x,y,k,min] = steepest_descent_projection(f,gradf,x_start,y_start,epsilon,gamma,s,a1,a2,b1,b2)
    set(groot,'defaultAxesXGrid','on')
    set(groot,'defaultAxesYGrid','on')
        
    x = x_start;
    y = y_start;
    x_estimate =x;
    y_estimate = y;
    
    k = 1;
    
    figure();
    fcontour(f, [-10, 10, -10, 10]);
    colorbar
    hold on;
    plot(x,y,'bo');
    while norm(subs(gradf)) > epsilon
        d = - vpa(subs(gradf));
        
        pr_x = x +s*d(1);
        pr_y = y + s*d(2);
        
        if (pr_x<a1)
            pr_x = a1;
        elseif (pr_x>b1)
            pr_x = b1;
        end
           
        if (pr_y<a2)
            pr_y = a2;
        elseif (pr_y>b2)
            pr_y = b2;
        end
        
        x = x + gamma*(pr_x - x);
        y = y + gamma*(pr_y - y);   
        
        plot(x,y,'bo');

        k = k+1;
        x_estimate = [x_estimate; x];
        y_estimate = [y_estimate; y];
        
        if k == 200 
            break;
        end
    end
    plot(x,y,'r*','MarkerSize',20);
    hold off;
    title(['Minimum estimation with gamma =' num2str(gamma)]);
    xlabel('x');
    ylabel('y');
%     saveas(gcf,'figure1.png');

    min = subs(f);
    
    figure();
    fsurf(f, [-10, 10, -10, 10]);
    colorbar
    hold on;
    plot(x,y,'r*','MarkerSize',30,'LineWidth', 10);
    hold off;
    title(['Minimum point with gamma =' num2str(gamma)]);
    xlabel('x');
    ylabel('y');
    zlabel('f(x,y)');
%     saveas(gcf,'figure2.png');
    
    figure()
    plot3(1:k, x_estimate,y_estimate,'-*');
    title(['Point alterations with gamma =' num2str(gamma)]);
    xlabel('k');
    ylabel('x');
    zlabel('y');
%     saveas(gcf,'figure3.png');  
    
    figure()
    plot(1:k, x_estimate,'r-o');
    title(['x alterations with gamma =' num2str(gamma)]);
    xlabel('k');
    ylabel('x');
%     saveas(gcf,'figure4.png');
    
    figure()
    plot(1:k, y_estimate,'k-x');
    title(['y alterations with gamma =' num2str(gamma)]);
    xlabel('k');
    ylabel('y');
%     saveas(gcf,'figure5.png');
        
    fprintf('Best minimum estimation: f(%f,%f) = %f after %d repetitions\n',x,y,min,k);

end

