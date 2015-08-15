function [output] = thresholdingBasedFOA(originalImage,threshold)
output = originalImage;
for i=1:size(output,1)
    for j=1:size(output,2)
        if(output(i,j)>=threshold)
            output(i,j)=255;
        else
            output(i,j)=0;
        end
    end
end
end