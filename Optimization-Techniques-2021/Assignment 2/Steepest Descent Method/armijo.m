function [g] = armijo(x,y,d)
    a = 0.001;
    b = 0.3;
    s = 7;
    mk = 0;
    gamma = s*b^mk;
    
    x1 = x + d(1)*gamma;
    y1 = y + d(2)*gamma;
    
    while (f(x,y,2) - f(x1,y1,2)) < (-a*b^mk*s*gradf(x,y)*d')
        mk = mk+1
        gamma = s*b^mk;
        x1 = x + d(1)*gamma;
        y1 = y + d(2)*gamma;
    end
    g = gamma;
end

