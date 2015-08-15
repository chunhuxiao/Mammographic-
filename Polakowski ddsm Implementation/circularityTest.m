function passed = circularityTest(ROI)
areaOfROI = findArea(ROI);
perimeter = findPerimeter(ROI);
circularity = (perimeter*perimeter)/(4*pi*areaOfROI);
if( circularity > 0.20 )
    passed = 1;
else
    passed = 0;
end