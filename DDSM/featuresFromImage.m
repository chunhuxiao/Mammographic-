function [features] = featuresFromImage(filePath,width, height, hasOverlay, overlayFilePath)
if( hasOverlay == 0)
    features = [];
    return;
end

image_size=[width height];
fid = fopen(filePath,'r','b');
originalImage=fread(fid,[image_size(1) image_size(2)],'uint16');
originalImage= originalImage';
max_int = max(max(originalImage));
originalImage = (255/(max_int))*originalImage;
originalImage = [ zeros(height,100),originalImage,zeros(height,100)];
originalImage = uint8(originalImage);
%originalImage = imresize(originalImage,0.25);
originalImage = adapthisteq(originalImage);
fclose(fid);

features = [];
if( hasOverlay == 1)
    groundTruths = get_ddsm_groundtruth(overlayFilePath);
    hasMass = 0;
    for j=1:size(groundTruths)
        groundTruth = groundTruths{j};
        lesion_type = groundTruth.lesion_type;
        temp2 = strfind(lesion_type,'MASS');
        if ( size(temp2,1) ~= 0 )
            hasMass = 1;
            bitMask = groundTruth.annotations.boundary([width,height]);
            bitMask = uint8(bitMask);
            %bitMask = imresize(bitMask,0.25);
            bitMask = bitMask';
            bitMask = double(bitMask);

            for i=1:size(bitMask,1)
                for j=1:size(bitMask,2)
                    if( bitMask(i,j)==0)
                        bitMask(i,j)=-1;
                    end
                end
            end
            boundingBoxes = findBoundingBoxes(bitMask,1);
            temp = predictionModule(originalImage,bitMask,boundingBoxes);
            features = [features;temp];
        end
    end
    if( hasMass==0 )
        features = [];
        return;
    end
end
features = [features,ones(size(features,1),1)];
return;

%originalImage = imread(completePath);
%originalImage = imread('/home/rajeev/Dropbox/BTP/Databases/Enhanced/mdb028e.pgm');
threshold = 200;
binaryImage = thresholdingBasedFOA(originalImage,threshold);
%binaryImage = FOAModule(originalImage);
[bitMask, ROIranges] = indexModule(originalImage,binaryImage);
if( hasOverlay==0 )
    labels = zeros(size(ROIranges,1),1);
else
    labels = findLabel(ROIranges,groundTruths,width,height);
end
features = predictionModule(originalImage,bitMask,ROIranges);
features = [features,labels]; 
end