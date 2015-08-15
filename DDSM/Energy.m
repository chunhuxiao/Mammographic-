function E = Energy(GLCM)
  E = sum(sum(GLCM.^2));
end