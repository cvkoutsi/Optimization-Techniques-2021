%Optimization Teichniques- Exercise 1- Bisection Method
%Task 1-Minimizing function using variable epsilon  

clear
clc

set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

a = -4;
b = 4;
l = 0.01;
% e = [0.0045  0.004 0.0005 0.0001 0.00005 0.00001];
e = linspace(0.0001,0.0045,10);
n = length(e);
min_estimate = zeros(3,n);
x_estimate = zeros(3,n);
        
nOfRep = zeros(3,n);

for i = 1:3
    for j = 1: n
        a = -4;
        b = 4;
        k = 0;
        
        while (b - a) >= l
            x1 = (a + b)/2 - e(j);
            x2 = (a + b)/2 + e(j);

            if f(x1,i) < f(x2,i)
                b = x2;
            elseif f(x1,i) >= f(x2,i)
                a = x1;
            end
            k = k+1;      
        end
        nOfRep(i,j) = k;
        min_estimate(i,j) = (f(a,i) + f(b,i))/2; 
        x_estimate(i,j) = (a+b)/2;
    end
end


clf;

%figures for function 1
figure(1);
d1 = 3.1:0.001:3.2;
hold on;
plot(d1,f(d1,1));
plot(x_estimate(1,:),min_estimate(1,:),'+');
hold off;
title('Minimun of function 1');
ylabel('f1(x)');

figure(2)
plot(e,x_estimate(1,:),'b*');
title('x* of function 1 with variable e');
xlabel('epsilon');
ylabel('x*');

figure(3);
plot(e,nOfRep(1,:),'r--');
title('Repetitions for function 1');
xlabel('epsilon');
ylabel('Number of Repetitions');


%figures for function 2 
figure(4);
d2 = -0.34:-0.001:-0.46;
hold on;
plot(d2,f(d2,2));
plot(x_estimate(2,:),min_estimate(2,:),'+');
hold off;
title('Minimun of function 2');
ylabel('f2(x)');

figure(5);
plot(e,x_estimate(2,:),'b*');
title('x* of function 2 with variable e');
xlabel('epsilon');
ylabel('x*');

figure(6);
plot(e,nOfRep(2,:),'r--');
title('Repetitions for function 2');
xlabel('epsilon');
ylabel('Number of Repetitions');

%figures for function 3
figure(7);
d3 = -1.95:-0.001:-2.05;
hold on;
plot(d3,f(d3,3));
plot(x_estimate(3,:),min_estimate(3,:),'+');
hold off;
title('Minimun of function 3');
ylabel('f3(x)');

figure(8);
plot(e,x_estimate(3,:),'b*');
title('x* of function 3 with variable e');
xlabel('epsilon');
ylabel('x*');

figure(9);
plot(e,nOfRep(3,:),'r--');
title('Repetitions for function 3');
xlabel('epsilon');
ylabel('Number of Repetitions');
% 

