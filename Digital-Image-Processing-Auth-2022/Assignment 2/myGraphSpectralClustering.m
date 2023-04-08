function clusterIdx = myGraphSpectralClustering(anAffinityMat, k)
    W = anAffinityMat;
    D = diag(sum(W));
    L = D-W;
    [U,~] = eigs(L,D,k,'smallestreal');
    clusterIdx = kmeans(U,k);
end

