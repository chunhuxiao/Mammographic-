function passed = contrastTest(originalI, bitMask);
in = [];
out = [];
all = [];
numRows = size(originalI,1);
numCols = size(originalI,2);
for x=1:numRows
    for y=1:numCols
        all = [ all, originalI(x,y)];
        if( bitMask(x,y)>0)
            in = [in,originalI(x,y)];
        else
            out = [out,originalI(x,y)];
        end
    end
end
inAvg = mean(in);
outAvg = mean(out);
Avg = mean(all);
contrast = (inAvg-outAvg)/Avg;
if ( contrast >0.02)
    passed =1;
else
    passed = 0;
end
end