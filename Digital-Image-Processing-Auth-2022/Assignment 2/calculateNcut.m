function nCutValue = calculateNcut(anAffinityMat, clusterIdx)

    A = anAffinityMat(clusterIdx == 1,:);
    B = anAffinityMat(clusterIdx == 2,:);
    AA = anAffinityMat(clusterIdx == 1,clusterIdx == 1);
    BB = anAffinityMat(clusterIdx == 2,clusterIdx == 2);

    assocA = sum(sum(A));
    assocB = sum(sum(B));
    assocAA = sum(sum(AA));
    assocBB = sum(sum(BB));
    Nassoc = assocAA/assocA + assocBB/assocB;
    nCutValue = 2 - Nassoc;

end

