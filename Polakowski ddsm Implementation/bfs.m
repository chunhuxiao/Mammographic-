function [visited]  = bfs(x,y,visited,numROI)
visited(x,y) = numROI;
numRows = size(visited,1);
numCols = size(visited,2);
dx = [1, -1, 0 , 0];
dy = [0, 0, 1, -1];
queueX = [x];
queueY = [y];
while( numel(queueX)>0 )
    X = queueX(1);
    Y = queueY(1);
    queueX = queueX(2:end);
    queueY = queueY(2:end);
    for i=1:4
        nX = X+dx(i);
        nY = Y+dy(i);
        if(nX<1 || nX>numRows || nY<1 || nY>numCols || visited(nX,nY)~=0)
            continue;
        end
        visited(nX,nY)=numROI;
        queueX = [queueX,nX];
        queueY = [queueY,nY];
    end
end