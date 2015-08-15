function [bitMask] = erode(bitMask)
se = strel('ball',5,5);
bitMask = imerode(bitMask,se);
end