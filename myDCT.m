function imdct = myDCT(im, F)
    imdct = dct2(im);
    %imdct = F*im*F';
end