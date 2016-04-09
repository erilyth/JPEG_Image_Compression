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

dct_image = zeros(size(im,1)+8, size(im,2)+8);

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
        %disp(current_dct);
        %disp(quantized_image_dct);
        for k = 1:8
            for l = 1:8
                dct_image(i*8+k,j*8+l) = current_dct(k,l);
            end
        end
    end
end

figure, imshow(im, [0 255]);
figure, imshow(dct_image, [0 255]);

%Observations:
%1) We can see how the boundaries of the original image can be seen. The
%changes of frequencies we get in 8x8 squares where there are a lot of
%colours are of a wider range, so the DCT matrix has lesser number of
%zeros, so we observe small white patches instead of just small white dots. 
%In places where the colours of the image are similar, there are a
%lot of zeros, so we observe small white dots.
%2) Just the DCT without any quantization can help us identify the image in
%black and white when we construct an image from the DCT.
%3) These can help us figure out divisions of our actual image which can be
%used in a lot of ways.