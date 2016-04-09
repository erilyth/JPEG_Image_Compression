function entropyy = My_entropy(im)
histogram = (imhist(im))/sum(imhist(im));
entropyy = 0;
for i = 1:size(histogram)
    if histogram(i) ~= 0
        %Formula for calculating the entropy of an image
        entropyy = entropyy - (histogram(i).*log2(histogram(i)));
    end
end
end