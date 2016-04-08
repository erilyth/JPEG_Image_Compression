function imdct = myDCT(im, F)
    %imdct = dct2(im);
    imdct = F*double(im)*F';
end