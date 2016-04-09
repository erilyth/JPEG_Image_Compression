%Reconstruct the image, find the highest values of c so that the
%distortions of the image are just perceptible. Give entropy and RMSE for different
%values of c. Explain results obtained with c = 10.

%Illuminance matrix
Q=[16  11  10  16  24  40  51  61;
    12  12  14  19  26  58  60  55;
    14  13  16  24  40  57  69  56;
    14  17  22  29  51  87  80  62;
    18  22  37  56  68  109 103 77;
    24  35  55  64  81  104 113 92;
    49  64  78  87  103 121 120 101;
    72  92  95  98  112 100 103 99];

im = imread('LAKE.TIF');
im = im(:,:,1);

quantized_image = zeros(size(im,1)+8, size(im,2)+8);

for i = 1:size(im,1)/8
    for j = 1:size(im,2)/8
        current_im = zeros(8,8);
        for k = 1:8
            if size(im,1) < i*8+k
                for l = 1:8
                    current_im(k,l) = 0;
                end
            else
                for l = 1:8
                    if size(im,2) < j*8+l
                        current_im(k,l) = 0;
                    else
                        current_im(k,l) = im(i*8+k,j*8+l);
                    end
                end
            end
        end
        current_dct = myDCT(current_im, create_mat_dct());
        %Use c = 3 when quantizing.
        quantized_image_dct = myDCT_dequantization(myDCT_quantization(current_dct, Q, 3), Q, 3);
        quantized_image_cur = myIDCT(quantized_image_dct, create_mat_dct());
        %disp(current_dct);
        %disp(quantized_image_dct);
        for k = 1:8
            for l = 1:8
                quantized_image(i*8+k,j*8+l) = quantized_image_cur(k,l);
            end
        end
    end
end

figure, imshow(im, [0 255]);
figure, imshow(quantized_image, [0 255]);

disp(My_entropy(quantized_image));
disp(RMSE(im, quantized_image));

%Observations:
%1)With c = 1, Entropy of the quantized image = -4790100, RMSE of original
%and quantized image = 20.1380
%2)With c = 3, Entropy of the quantized image = -4790000, RMSE of original
%and quantized image = 20.9356. At this point the distortions of the
%reconstructed image are just perceptible. So the highest value of c = 3,
%so that the distortions are just perceptible.
%3)With c = 5, Entropy of the quantized image = -4789800, RMSE of original
%and quantized image = 21.6818.
%4)With c = 10, Entropy of the quantized image = -4789000, RMSE of original
%and quantized image = 23.4657. The RMSE is quite higher compared to with
%c=1, so we can see that the image is distorted. On observing the image, we
%will find a lot of places where it is hard to identify boundaries, edges
%etc since the image is heavily distorted.
%5)With c = 30, Entropy of the quantized image = -4784100, RMSE of original
%and quantized image = 30.6674. We can barely tell that the two images are
%the same. We can't identify any specific object in the image.

%We can see that the Entropy goes on decreasing as c increased. As c increases,
%the image becomes distorted and nearby pixels start having similar/same
%values, so the entropy of the image decreases.
%The RMSE however always increased as c increased, since the image became 
%more and more distorted.
