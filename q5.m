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


RMSE_list = zeros(1,100);
entropy_list = zeros(1,100);

%Loop over p which we use as c for the quantization
for p = 1:2:100
    quantized_image = zeros(size(im,1)+8, size(im,2)+8);
    for i = 1:size(im,1)/8
        for j = 1:size(im,2)/8
            current_im = zeros(8,8);
            for k = 1:8
                if size(im,1) < i*8+1+k
                    for l = 1:8
                        current_im(k,l) = 0;
                    end
                else
                    for l = 1:8
                        if size(im,2) < j*8+1+l
                            current_im(k,l) = 0;
                        else
                            current_im(k,l) = im(i*8+k,j*8+l);
                        end
                    end
                end
            end
            current_dct = myDCT(current_im, create_mat_dct());
            %Use c = 3 when quantizing.
            quantized_image_dct = myDCT_dequantization(myDCT_quantization(current_dct, Q, p), Q, p);
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
    entropy_list(p) = My_entropy(quantized_image);
    RMSE_list(p) = RMSE(im, quantized_image);
end

disp(entropy_list);
disp(RMSE_list);

plot(entropy_list, RMSE_list);