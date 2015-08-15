function perimeter = findPerimeter(ROI)
numRows = size(ROI,1);
numCols = size(ROI,2);
perimeter = 0;
for x=1:numRows
    for y=2:numCols
        if( ROI(x,y) ~=ROI(x,y-1) )
            perimeter= perimeter+1;
        end
    end
end
end