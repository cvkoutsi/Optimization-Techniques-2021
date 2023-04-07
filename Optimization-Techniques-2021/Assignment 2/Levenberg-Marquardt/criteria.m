function [check] = criteria(x,y,d,gk)
    check_3 = false;
    check_4 = false;
    
    %check for criterion 3
    x1 = x + d(1)*gk;
    y1 = y + d(2)*gk;
    for b = linspace(0.001,1,50)
        if d'*gradf(x1,y1) <= b*d'*gradf(x,y)
            continue;
        else
            check_3 = true;
            break;
        end
    end
    
    %check for criterion 4
    for a = linspace(0.001,b,50)
        if f(x1,y1,2) > f(x,y,2) + a*gk*d'*gradf(x,y)
            continue;
        else
            check_4 = true;
            break;
        end
    end
    
    check = check_3 && check_4;
        
end

