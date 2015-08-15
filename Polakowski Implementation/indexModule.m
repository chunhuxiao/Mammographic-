function [bitMask,ROIranges]= indexModule(originalImage,binaryImage)
%originalImage= imread('mdb023e.pgm');
%binaryImage=imread('binaryImage.pgm');
numRows = size(originalImage,1);
numCols = size(originalImage,2);
visited = zeros(numRows,numCols);
numROIs=0;

%marking non-ROIs regions as visited;
for x=1:numRows
    for y=1:numCols
        if( binaryImage(x,y)==0 )
            visited(x,y)=-1;
        end
    end
end
%bfs to search for ROIs
for x=1:numRows
    for y=1:numCols
        if(visited(x,y)==0)
            numROIs = numROIs+1;
            visited=bfs(x,y,visited,numROIs);
        end
    end
end
%Selecting the top 7 ROIs

boundingBoxes = findBoundingBoxes(visited, numROIs);
boundingBoxToPerimeterRatio = findBindingBoxToPerimeterRatio(boundingBoxes,visited);
[temp, indices] = sort(boundingBoxToPerimeterRatio,'descend');
numSelectedROI = min(10,size(indices,1));
selectedIndices = indices(1:numSelectedROI);
hashMap = zeros(1,numROIs);
for i=1:numSelectedROI
    hashMap(selectedIndices(i))=1;
end
for x=1:numRows
    for y=1:numCols
        j=visited(x,y);
        if(j==-1)
            continue;
        end
        if( hashMap(j)==0 )
            visited(x,y)=-1;
        end
    end
end
%%%%%%%%%%%%% Selected the Top ROIs

%Selecting top 15% intensities from each ROI
bitMask = zeros(numRows,numCols);
ROIranges=[];
for i=1:numROIs
    if( hashMap(i)==0 )
        continue;
    end
    [r1,r2, c1, c2] = findCentroid(boundingBoxes(i,:));
    ROIranges=[ROIranges;r1,r2,c1,c2];
    ROI140 = originalImage(r1:r2,c1:c2);
    thresholdIntensity = find15pThreshold(ROI140);
    for x=r1:r2
        for y=c1:c2
            if( originalImage(x,y)>=thresholdIntensity)
                bitMask(x,y)=255;
                %bitMask(x,y) = originalImage(x,y);
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bitMask = erode(bitMask);
bitMask = 255*(bitMask >0); 
%%%%% Area Test
numROIRemaining = size(ROIranges,1);
%imshow(uint8(bitMask));
areaThreshold = 500;
hashMap = zeros(numROIRemaining,1);
for i=1:numROIRemaining
    r1 = ROIranges(i,1);
    r2 = ROIranges(i,2);
    c1 = ROIranges(i,3);
    c2 = ROIranges(i,4);
    area = findArea(bitMask(r1:r2,c1:c2));
    if ( area < areaThreshold )
        bitMask(r1:r2,c1:c2)= zeros(r2-r1+1,c2-c1+1);
    else
        hashMap(i,1)=1;
    end
end
temp = ROIranges;
ROIranges=[];
temp2 = 0;
for i=1:numROIRemaining
    if ( hashMap(i,1)==1 )
        ROIranges = [ ROIranges; temp(i,1),temp(i,2),temp(i,3),temp(i,4)];
        temp2= temp2 + 1;
    end
end
numROIRemaining = temp2;

% Area test complete
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Starting Contrast Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hashMap = zeros(numROIRemaining,1);
for i=1:numROIRemaining
    r1 = ROIranges(i,1);
    r2 = ROIranges(i,2);
    c1 = ROIranges(i,3);
    c2 = ROIranges(i,4);
    passed = contrastTest(originalImage(r1:r2,c1:c2), bitMask(r1:r2,c1:c2) );
    if(passed==0)
        bitMask(r1:r2,c1:c2)= zeros(r2-r1+1,c2-c1+1);
    else
        hashMap(i) = 1;
    end
end

temp = ROIranges;
ROIranges=[];
temp2 = 0;
for i=1:numROIRemaining
    if ( hashMap(i,1)==1 )
        ROIranges = [ ROIranges; temp(i,1),temp(i,2),temp(i,3),temp(i,4)];
        temp2= temp2 + 1;
    end
end
numROIRemaining = temp2;


%Contrast test Complete
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Starting Circularity Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hashMap = zeros(numROIRemaining,1);
for i=1:numROIRemaining
    r1 = ROIranges(i,1);
    r2 = ROIranges(i,2);
    c1 = ROIranges(i,3);
    c2 = ROIranges(i,4);
    passed = circularityTest(bitMask(r1:r2,c1:c2));
    if(passed==0)
        bitMask(r1:r2,c1:c2)= zeros(r2-r1+1,c2-c1+1);
    else
        hashMap(i) = 1;
    end
end


temp = ROIranges;
ROIranges=[];
temp2 = 0;
for i=1:numROIRemaining
    if ( hashMap(i,1)==1 )
        ROIranges = [ ROIranges; temp(i,1),temp(i,2),temp(i,3),temp(i,4)];
        temp2= temp2 + 1;
    end
end

%%Completed Circularity Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end