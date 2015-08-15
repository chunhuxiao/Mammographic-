function [output] = FOAModule(I)
  I = double(I);
  %I = double(imread('mdb023e.pgm'));
  h1 = fspecial('gaussian',[30 30],40);
  h2 = fspecial('gaussian',[30 30],60);
  gauss1 = imfilter(I,h1,'replicate');
  gauss2 = imfilter(I,h2,'replicate');
  output= (gauss1-gauss2)*255;
  output = uint8(output);
  for i=1:size(output,1)
      for j=1:size(output,2)
          if( output(i,j)>10)
              output(i,j)=255;
          else
              output(i,j)=0;
          end
      end
  end
  %output = (output>30);
  %output = uint8(output);
  %output = 255*output;
  %imshow(output);
end