function responseCurve = estimateResponseCurve(imgStack, exposureTimes, smoothingLamda, weightingFcn)
    Z = imgStack;
    B = log(exposureTimes);
    l = smoothingLamda;
    
    n = 256;
    A = zeros(size(Z,1)*size(Z,2)+n+1,n+size(Z,1));
    b = zeros(size(A,1),1);
    %% Include the data?fitting equations
    k = 1;
    for i=1:size(Z,1)
        for j=1:size(Z,2)
            wij = w(Z(i,j)+1,weightingFcn,exposureTimes(j));
            A(k,Z(i,j)+1) = wij;
            A(k,n+i) = -wij;
            b(k,1) = wij * B(j);
            k=k+1;
        end
    end
    %% Fix the curve by setting its middle value to 0
    A(k,129) = 1;
    k=k+1;
    %% Include the smoothness equations
    for i=1:n-2
        A(k,i)=l*w(i+1,weightingFcn,1);
        A(k,i+1)=-2*l*w(i+1,weightingFcn,1);
        A(k,i+2)=l*w(i+1,weightingFcn,1);
        k=k+1;
    end

    %% Solve the system using SVD
    x = A\b;
    responseCurve = x(1:n);
    LE = x(n+1:size(x,1));
end

%% Function that implements the weight functions
function weight = w(img,i,t)
    z_min = 0;
    z_max = 256;
    condition = img >= z_min & img <= z_max;
    if i == 1
        if condition
            weight = 1;
        else
            weight = 0;
        end
    elseif i == 2
        if condition
            weight = min(img,255-img);
        else
            weight = 0;
        end
    elseif i == 3    
        if condition
            weight = exp((-4)*(((img - z_max*0.5).^2)/(z_max*0.5)^2));
        else
            weight = 0;
        end
    elseif i == 4
        if condition
            weight = t;
        else
            weight = 0;
        end
    end
end