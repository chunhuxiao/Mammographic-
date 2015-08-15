function [boundingBoxes] = findBoundingBoxes(visited,numROI)
numRows = size(visited,1);
numCols = size(visited,2);
boundingBoxes = zeros(numROI,4);

for i=1:numROI
    boundingBoxes(i,1)= 100000000;
    boundingBoxes(i,2) = -1;
    boundingBoxes(i,3) = 10000000;
    boundingBoxes(i,4) = -1;
end

for x=1:numRows
    for y=1:numCols
        j = visited(x,y);
        if( j==-1)
            continue;
        end
        boundingBoxes(j,1) = min(boundingBoxes(j,1),x);
        boundingBoxes(j,2) = max(boundingBoxes(j,2),x);
        boundingBoxes(j,3) = min(boundingBoxes(j,3),y);
        boundingBoxes(j,4) = max(boundingBoxes(j,4),y);
    end
end

end