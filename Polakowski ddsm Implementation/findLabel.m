function [label] = findLabel(ROIranges,groundTruth,width,height)
numROI = size(ROIranges,1);
label = zeros(numROI,1);
for i=1:numROI
  label(i)=0;
  for j=1: size(groundTruth):
      temp = groundTruth{j};
      lesion_type = temp.lesion_type;
      annot = temp.annotations.boundary([width,height]);
      annot = annot';
      annot = [ zeros(height,100),annot,zeros(height,100)];
      x1 = ROIranges(i,1);
      x2 = ROIranges(i,2);
      y1 = ROIranges(i,3);
      y2 = ROIranges(i,4);
      temp2 = annot(x1:x2,y1:y2);
      s = sum(sum(temp2));
      if( s>0 )
          label(i)= 1;
      end
end
end