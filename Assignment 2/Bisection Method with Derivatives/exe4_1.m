%Optimization Teichniques- Exercise 2- Bisection Method with Derivative
%Minimizing function using variable lamda  

clear
clc
clf

l = linspace(0.00025,0.01,10);
nOfTrials = length(l);
min_estimate = zeros(3,nOfTrials);
x_estimate = zeros(3,nOfTrials);
nOfRep = zeros(3,nOfTrials);

m = 0;

for i = 1:3
    for j = 1: nOfTrials 
        a = -4;
        b = 4;
        k = 0;
        n = 0;
        
        lowerLimit = a;
        upperLimit = b;
        
        while (0.5)^n >= l(j)/(b-a)
            x = (a + b)/2;
            this_df = df(x,i);
            
            if this_df == 0
                break;
            elseif this_df > 0
                b = x;            
            elseif this_df < 0
                a = x;
            end
            
            lowerLimit = [lowerLimit; a];
            upperLimit = [upperLimit; b];
            n = n +1;
        end
        k = length(lowerLimit);
        nOfRep(i,j) = k;

        min_estimate(i,j) = (f(a,i) + f(b,i))/2;
        x_estimate(i,j) = (a+b)/2;
        
        if j == 1 || j == 10
            m = m +1;
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
d1 = 2.8:0.001:3.5;
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
% % 
% % 
% % %figures for function 2 
figure(10);
d2 = -0.2:-0.001:-0.5;
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
% % 
% % %figures for function 3
figure(13);
d3 = -1.9:-0.001:-2.2;
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