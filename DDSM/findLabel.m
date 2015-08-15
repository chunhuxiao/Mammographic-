function [label] = findLabel(ROIranges,groundTruth,width,height)
numROI = size(ROIranges,1);
label = zeros(numROI,1);
for j=1:size(groundTruth)
    temp = groundTruth{j};
    lesion_type = temp.lesion_type;
    temp2 = strfind(lesion_type,'MASS');
    hasMass = 1;
    if( size(temp2,1)==0 )
        hasMass=0;
    end
    annot = temp.annotations.boundary([width,height]);
    annot = annot';
    annot = [ zeros(height,100),annot,zeros(height,100)];
    annot = imresize(annot,0.25);
    for i=1:numROI
      x1 = ROIranges(i,1);
      x2 = ROIranges(i,2);
      y1 = ROIranges(i,3);
      y2 = ROIranges(i,4);
      temp2 = annot(x1:x2,y1:y2);
      s = sum(sum(temp2));
      if( s>0 && hasMass==1)
          label(i)= 1;
      end
    end
end
end