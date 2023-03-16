function [z] = f(x1,y1,i)
    syms x y
    f = x^3*exp(-x^2 -y^4);
    %parametric representation of f
    if i == 1
        z = f;
    %point representation of f
    else
        z = vpa(subs(f,[x,y],[x1,y1]));
    end
end