function outputImage = superpixelDescriptor(imIn, labels)
    imIn = double(imIn);
    [M,N,z] = size(imIn);
    outputImage = zeros(M,N,z);

    l =double(unique(labels)); %find the labels
    
    for i = 1:length(l)
        [k,d] = find(labels == l(i));

        ind = sub2ind(size(outputImage),k,d,ones(length(k),1));
        outputImage(ind) = mean(imIn(ind),'all');
        ind = sub2ind(size(outputImage),k,d,2*ones(length(k),1));
        outputImage(ind) = mean(imIn(ind),'all');
        ind = sub2ind(size(outputImage),k,d,3*ones(length(k),1));
        outputImage(ind) = mean(imIn(ind),'all');
    end

    outputImage = uint8(outputImage);
end

