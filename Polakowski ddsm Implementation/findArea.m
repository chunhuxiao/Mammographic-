function area = findArea(ROI)
numRows = size(ROI,1);
numCols = size(ROI,2);
area = 0;
for x=1:numRows
    for y=1:numCols
        if( ROI(x,y)>0)
            area = area +1;
        end
    end
end
end