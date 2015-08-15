function [features] = featuresFromImage(fileName,width, height, hasOverlay, overlayFileName)
%fileName
completePath = strcat('/home/rajeev/ddsm/figment.csee.usf.edu/pub/DDSM/cases/cancers/cancer_01/all/',fileName);
image_size=[width height];
fid = fopen(completePath,'r','b');
originalImage=fread(fid,[image_size(1) image_size(2)],'uint16');
originalImage= originalImage';
max_int = max(max(originalImage));
originalImage = (255/(max_int))*originalImage;

originalImage = [ zeros(height,100),originalImage,zeros(height,100)];

originalImage = uint8(originalImage);
originalImage = adapthisteq(originalImage);
imshow(originalImage);
fclose(fid);

%originalImage = imread(completePath);
%originalImage = imread('/home/rajeev/Dropbox/BTP/Databases/Enhanced/mdb028e.pgm');
threshold = 200;
binaryImage = thresholdingBasedFOA(originalImage,threshold);
%binaryImage = FOAModule(originalImage);
[bitMask, ROIranges] = indexModule(originalImage,binaryImage);
if( hasOverlay==0 )
    labels = zeros(size(ROIranges,1),1);
else
    completePath = strcat('/home/rajeev/ddsm/figment.csee.usf.edu/pub/DDSM/cases/cancers/cancer_01/all/',overlayFileName);
    groundTruth = get_ddsm_groundtruth(completePath);
    
    labels = findLabel(ROIranges,groundTruth,width,height);
end
if(sum(labels)==0)
    fileName
end
features = predictionModule(originalImage,bitMask,ROIranges);
features = [features,labels]; 
end