
function [y] = f(x, i)
    if i==1
        y = (x-3).^2 + (sin(x+3)).^2;
    elseif i==2
        y = (x-1).*cos(0.5.*x) + x.^2;
    elseif i==3
        y = (x+2).^2 + exp(x-2).*sin(x+3);
    else
        y = [];
    end
end