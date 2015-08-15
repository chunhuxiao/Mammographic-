function threshold = find15pThreshold(ROI)
pixels = [];
numRows = size(ROI,1);
numCols = size(ROI,2);
for x=1:numRows
    for y=1:numCols
        pixels = [ pixels,ROI(x,y)];
    end
end
n = size(pixels,2);
[sortedIntensityValues] = sort(pixels,'descend');
n15p = ceil(0.15*n);
threshold = sortedIntensityValues(n15p);
end
