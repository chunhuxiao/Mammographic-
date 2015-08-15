function I =Inertia(GLCM)
  s  = size(GLCM);
  A = ones(s(1),s(2));
  for i=1:s(1)
      for j=1:s(2)
          A(i,j) = (i-j)^2;
      end
  end
  B = GLCM.*A;
  I = sum(sum(B));
end

