function [features] = featuresFromImage(fileName,row,col)
%fileName
completePath = strcat('/home/vishwash/BTP/BTP/Databases/Enhanced/',fileName);
originalImage = imread(completePath);
%originalImage = imread('/home/rajeev/Dropbox/BTP/Databases/Enhanced/mdb028e.pgm');
binaryImage = thresholdingBasedFOA(originalImage,200);
%binaryImage = FOAModule(originalImage);
[bitMask, ROIranges] = indexModule(originalImage,binaryImage);
labels = findLabel(ROIranges,row,col);
if(sum(labels)==0)
    fileName
end
features = predictionModule(originalImage,bitMask,ROIranges);
features = [features,labels]; 
end