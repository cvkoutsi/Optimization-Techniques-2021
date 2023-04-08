function myAffinityMat = Image2Graph(imIn,choose)
    if choose == 1
        [M,N,z] = size(imIn);
        myAffinityMat = zeros(M*N,M*N);

        %resize input image to a column vector
        if z == 1
            imIn = reshape(imIn,[],1,1);
        elseif z == 3
            imIn = reshape(imIn,[],1,3);
        end

        for i = 1:M*N
            for j = 1:M*N
                if z == 1
                    d = abs(imIn(i,1) - imIn(j,1));
                    myAffinityMat(i,j) = 1/exp(d);
                elseif z == 3
                    d = sqrt((imIn(i,1,1) - imIn(j,1,1))^2 + (imIn(i,1,2) - imIn(j,1,2))^2 + (imIn(i,1,3) - imIn(j,1,3))^2);
                    myAffinityMat(i,j) = 1/exp(d);
                end
            end
        end
    elseif choose==2 
        l = length(imIn);
        myAffinityMat = zeros(l,l);
        for i = 1:l
            for j = 1:l
                d = sqrt((imIn(i,1) - imIn(j,1))^2 + (imIn(i,2) - imIn(j,2))^2 + (imIn(i,3) - imIn(j,3))^2);
                myAffinityMat(i,j) = 1/exp(d); 
            end
        end
    end
    
end