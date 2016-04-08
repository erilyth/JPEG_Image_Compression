%Quantize the image following JPEG compression techniques and then
%dequantize it and recreate the original image.

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
        %With c = 10, we can still identify the image quite well.
        quantized_image_dct = myDCT_dequantization(myDCT_quantization(current_dct, Q, 10), Q, 10);
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

%Observations:
%1) With a value of c=2, the image almost looks as if there was no change
%to it, but the DCT matrices we are using after quantization have very few
%numbers which need to be stored (rest all are 0s) compared to the original
%DCT matrices without quantization.
%2) With a value of c=30, the image seems highly distorted, we can barely identify 
%whats present in the image. The DCT matrices after quantization, most of them just 
%have 1 value at the top left corner and thats all, so that is a huge amount of compression.
%3) I have used c=10 above, and we can see that the image can be identified
%easily but it does seem disturbed (imperfections etc).
%4) As we increase the value of c, the image seems to be more pixelated. We
%can see that the changes of colour across surfaces etc is not that smooth
%anymore.