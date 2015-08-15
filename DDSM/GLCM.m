function f = GLCM(I)
deltaX1 = 10;
deltaX2 = 10;
[rows, cols]= size(I);
I = uint8(I);
C = zeros(256,256);
for i=1:rows
    for j=1:cols
        k1=i+deltaX1;
        k2=j+deltaX2;
        if( k1>rows || k2>cols )
            continue;
        end
        C( I(i,j)+1,I(k1,k2)+1)= C(I(i,j)+1,I(k1,k2)+1)+1;
    end
end
f = [Energy(C),Inertia(C)];
end