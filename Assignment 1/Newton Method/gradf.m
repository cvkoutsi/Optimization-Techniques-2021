function [z] = gradf(x1,y1)
    syms x y 
    f = (x^3)*exp(-x^2-y^4);
    f1 = jacobian(f,[x,y]);
    z = vpa(subs(f1,[x,y],[x1,y1]));

end

