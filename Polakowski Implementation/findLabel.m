function [label] = findLabel(ROIranges,row,col)
numROI = size(ROIranges,1);
label = zeros(numROI,1);
for i=1:numROI
    r1 = ROIranges(i,1);
    r2 = ROIranges(i,2);
    c1 = ROIranges(i,3);
    c2 = ROIranges(i,4);
    if( r1<=row && r2>=row && c1<=col && c2>=col)
        label(i)=1;
    else
        label(i) = -1;
    end
end
end