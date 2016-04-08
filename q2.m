%Observe DCT, quantized DCT and the reconstructed image for 8x8 subwindows 
%at 3 locations of the original image.

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

display(im(420:428,45:53));

original_image_dct1 = myDCT(im(420:428,45:53), create_mat_dct());
original_image_dct2 = myDCT(im(427:435,298:306), create_mat_dct());
original_image_dct3 = myDCT(im(30:38,230:238), create_mat_dct());
quantized_image_dct1 = myDCT_dequantization(myDCT_quantization(original_image_dct1, Q, 2), Q, 2);
quantized_image_dct2 = myDCT_dequantization(myDCT_quantization(original_image_dct2, Q, 2), Q, 2);
quantized_image_dct3 = myDCT_dequantization(myDCT_quantization(original_image_dct3, Q, 2), Q, 2);

disp(original_image_dct1);
disp(quantized_image_dct1);
disp(original_image_dct2);
disp(quantized_image_dct2);
disp(original_image_dct3);
disp(quantized_image_dct3);

original_image1 =  myIDCT(original_image_dct1, create_mat_dct());
quantized_image1 = myIDCT(quantized_image_dct1, create_mat_dct());
original_image2 =  myIDCT(original_image_dct2, create_mat_dct());
quantized_image2 = myIDCT(quantized_image_dct2, create_mat_dct());
original_image3 =  myIDCT(original_image_dct3, create_mat_dct());
quantized_image3 = myIDCT(quantized_image_dct3, create_mat_dct());

figure, imshow(quantized_image1, [0 255]);
figure, imshow(quantized_image2, [0 255]);
figure, imshow(quantized_image2, [0 255]);

%Observations:
%1)In all the quantized DCTs most of the entries towards the bottom right
%are 0's and has a lot less entries that need to be stored compared to the
%non-qunatized one.
%2)The quantized images at 427,298 and 30,230 are quite similar to each other even
%though their DCTs don't match completely. In the DCT at 30,230 has only 1
%entry in the DCT which matches the top left entry of the DCT at 427, 298.
%3)The quantized image at 420,45 is somewhat like a colour gradient from
%left to right (brightest at left, darkest at right)