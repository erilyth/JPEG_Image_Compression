function imqDCT = myDCT_quantization(imDCT, qm, c)
imqDCT = zeros(size(qm,1),size(qm,2));
for i = 1:size(qm,1)
    for j = 1:size(qm,2)
        imqDCT(i,j) = round(imDCT(i,j)./(qm(i,j).*c));
    end
end
end