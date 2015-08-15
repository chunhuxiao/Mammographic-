I=imread('mdb023e.pgm');
I2=I;
row = size(I2,1);
col = size(I2,2);
for x=1:1:row
    for y=1:1:col
        if( I2(x,y)<220 )
            I2(x,y)=0;
        else
            I2(x,y)=255;
        end
    end
end
%imshow(I2);
imwrite(I2,'binaryImage.pgm');