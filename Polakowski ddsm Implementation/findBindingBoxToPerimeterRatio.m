function Ratio =  findBindingBoxToPerimeterRatio(boundingBoxes,visited)
numBoxes = size(boundingBoxes,1);
Ratio = zeros(numBoxes,1);
for i=1:numBoxes
    x1 = boundingBoxes(i,1);
    x2 = boundingBoxes(i,2);
    y1 = boundingBoxes(i,3);
    y2 = boundingBoxes(i,4);
    area = (x2-x1)*(y2-y1);
    
    %perimeter = 2*(x2-x1) + 2*(y2-y1) + 1;
    temp = (visited==i);
    perimeter = findPerimeter(temp(x1:x2,y1:y2) );
    if(perimeter ~= 0 )
        Ratio(i)= area/perimeter;
    end
end
end