function radianceMap = mergeLDRStack(imgStack, exposureTimes, weightingFcn)
k = length(exposureTimes);
[M,N] = size(imgStack(:,:,1));

radiance = zeros(M,N);
weights = zeros(M,N);

for i = 1:k
    z = imgStack(:,:,i);
    t = exposureTimes(i);

    radiance = radiance + w(z,weightingFcn,t).*(log(z) - log(t));
    weights = weights + w(z,weightingFcn,t);
end

radianceMap= (radiance./weights); %can also be exp(radiance./weights)

end

%% Function that implements the weight functions
function weight = w(img,i,t)
    [M, N] = size(img);
    img = img/255;
    z_min = 0.05;
    z_max = 0.99;
    condition = img(:,:)>= z_min & img(:,:)<= z_max;
    
    if i == 1
        weight(condition) = 1;
        weight(~condition) = 0;
        weight = reshape(weight, [M,N]);
    elseif i == 2
        weight(condition) = min(img(condition),1-img(condition));
        weight(~condition) = 0;
        weight = reshape(weight, [M,N]);
    elseif i == 3
        weight(condition) = exp((-4) * (((img(condition) - 0.5).^2) ./ 0.5^2));
        weight(~condition) = 0;
        weight = reshape(weight, [M,N]);
    elseif i == 4
        weight(condition) = t;
        weight(~condition) = 0;
        weight = reshape(weight, [M,N]);
    end 
end