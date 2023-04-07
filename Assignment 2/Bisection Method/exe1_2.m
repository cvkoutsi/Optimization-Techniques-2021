%Optimization Teichniques- Exercise 1- Bisection Method
%Task 2-Minimizing function using variable lamda  

clear
clc
clf


set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

e = 0.001;
l = linspace(0.0025,0.01,10);
n = length(l);
min_estimate = zeros(3,n);
x_estimate = zeros(3,n);
nOfRep = zeros(3,n);

m = 0;

for i = 1:3
    for j = 1: n 
        a = -4;
        b = 4;
        k = 0;
        
        lowerLimit = a;
        upperLimit = b;
            while (b - a) >= l(j)
  
            x1 = (a + b)/2 - e;
            x2 = (a + b)/2 + e;

            if f(x1,i) < f(x2,i)
                b = x2;
            elseif f(x1,i) >= f(x2,i)
                a = x1;
            end
            lowerLimit = [lowerLimit; a];
            upperLimit = [upperLimit; b];
        end
        k = length(lowerLimit);
        nOfRep(i,j) = k;

        min_estimate(i,j) = (f(a,i) + f(b,i))/2;
        x_estimate(i,j) = (a+b)/2;
        
     
        if j == 1 || j == 10
            m = m+1;
            figure(m);
            hold on; 
            title(['Search interval for function ' num2str(i) 'and l = ' num2str(l(j))]);
            plot(1:k,lowerLimit,'--o');
            plot(1:k,upperLimit,'--x');
            set(gca,'XTick',(1:k));
            xlabel('k');
            legend({'left boundry', 'right boundry'},'Location', 'Northeast');
            hold off;
        end
    end
end

%
% %figures for function 1
figure(7);
d1 = 3.1:0.001:3.2;
hold on;
plot(d1,f(d1,1));
plot(x_estimate(1,:),min_estimate(1,:),'+');
hold off;
title('Minimun of function 1');
ylabel('f1(x)');

figure(8)
plot(l,x_estimate(1,:),'b*');
title('x* of function 1 with variable l');
xlabel('lamda');
ylabel('x*');

figure(9);
plot(l,nOfRep(1,:),'r--');
title('Repetitions for function 1');
xlabel('lamda');
ylabel('Number of Repetitions');
% 
% 
% %figures for function 2 
figure(10);
d2 = -0.34:-0.001:-0.46;
hold on;
plot(d2,f(d2,2));
plot(x_estimate(2,:),min_estimate(2,:),'+');
hold off;
title('Minimun of function 2');
ylabel('f2(x)');

figure(11);
plot(l,x_estimate(2,:),'b*');
title('x* of function 2 with variable l');
xlabel('lamda');
ylabel('x*');

figure(12);
plot(l,nOfRep(2,:),'r--');
title('Repetitions for function 2');
xlabel('lamda');
ylabel('Number of Repetitions');
% 
% %figures for function 3
figure(13);
d3 = -1.95:-0.001:-2.05;
hold on;
plot(d3,f(d3,3));
plot(x_estimate(3,:),min_estimate(3,:),'+');
hold off;
title('Minimun of function 3');
ylabel('f3(x)');

figure(14);
plot(l,x_estimate(3,:),'b*');
title('x* of function 3 with variable l');
xlabel('lamda');
ylabel('x*');

figure(15);
plot(l,nOfRep(3,:),'r--');
title('Repetitions for function 3');
xlabel('lamda');
ylabel('Number of Repetitions');