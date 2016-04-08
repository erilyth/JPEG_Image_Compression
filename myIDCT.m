function imidct = myIDCT(im, F)
    %imidct = idct2(im);
    imidct = F'*double(im)*F;
end