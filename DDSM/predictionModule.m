function features = predictionModule(originalImage,bitMask,ROIranges)
kernal = [ 1,4,6,4,1;
          -1,0,2,0,-1;
           1,-4,6,-4,1;
          -1,-2,0,2,1;
          -1,2,0,-2,1 ];
numROIs = size(ROIranges,1)
features = [];
for i=1:5
    for j=1:5;
        filter = kernal(i,:)' * kernal(j,:);
        outputImage = conv2(double(originalImage),double(filter));
        %figure;
        %imshow(uint8(outputImage));
        tempFeature = zeros(numROIs,1);
        for k=1:numROIs
            r1 = ROIranges(k,1);
            r2 = ROIranges(k,2);
            c1 = ROIranges(k,3);
            c2 = ROIranges(k,4);
            temp = 0;
            for x=r1:r2
                for y=c1:c2
                    if( bitMask(x,y)> 0 )
                        temp = temp + outputImage(x,y);
                    end
                end
            end
            tempFeature(k,1)=temp;
        end
        features = [features,tempFeature];
    end
end
tempFeatures = [];
for i=1:numROIs
            r1 = ROIranges(i,1);
            r2 = ROIranges(i,2);
            c1 = ROIranges(i,3);
            c2 = ROIranges(i,4);
            ROI = bitMask(r1:r2,c1:c2);
            ROI2 = originalImage(r1:r2,c1:c2);
            area = findArea(ROI);
            perimeter = findPerimeter(ROI);
            circularity = (perimeter*perimeter)/(4*pi*area);
            textureFeatures = GLCM(ROI2)
            tempFeatures = [tempFeatures;area,perimeter,circularity,textureFeatures];
end
features = [features,tempFeatures];
end