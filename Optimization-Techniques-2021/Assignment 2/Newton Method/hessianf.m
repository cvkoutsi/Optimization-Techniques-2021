function [z] = hessianf(x1,y1)
    syms x y 
    f = (x^3)*exp(-x^2-y^4);
    f1 = jacobian(f,[x,y]);
    f2 = jacobian(f1,[x,y]);
    z = vpa(subs(f2,[x,y],[x1,y1]));
 
%     syms x y 
%     f = (x^3)*exp(-x^2-y^4);
%     f1 = hessian(f,[x,y]);
%     z = vpa(subs(f1,[x,y],[x1,y1]));

end