function imDCT = myDCT_dequantization(imqDCT, qm, c)
imDCT = zeros(size(qm,1),size(qm,2));
for i = 1:size(qm,1)
    for j = 1:size(qm,2)
        imDCT(i,j) = round(imqDCT(i,j).*(qm(i,j).*c));
    end
end
end