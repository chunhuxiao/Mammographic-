function [r1,r2,c1,c2] = findCentroid(box)
cX = ceil((box(1)+box(2))/2);
cY = ceil((box(3)+box(4))/2);
r1 = max(1,cX-70);
r2 = min(1024,cX+70);
c1 = max(1,cY-70);
c2 = min(1024,cY+70);
end