function tonedImage = toneMapping(radianceMap, gamma)
    maximum = max(max(radianceMap));
    minimum = min(min(radianceMap));
    radianceMap = (radianceMap - minimum) ./ (maximum - minimum);
    
    tonedImage = radianceMap.^gamma;
    tonedImage = uint8(rescale(tonedImage,0,255));
end

