function [n] = find_n(a,b,l)
n = 2;
while ((b - a) / l) > fibonacci(n+1)
    n = n + 1;
end

