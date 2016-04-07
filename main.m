%disp(create_mat_dct());
%dctmtx(8);

Q=[16  11  10  16  24  40  51  61;
    12  12  14  19  26  58  60  55;
    14  13  16  24  40  57  69  56;
    14  17  22  29  51  87  80  62;
    18  22  37  56  68  109 103 77;
    24  35  55  64  81  104 113 92;
    49  64  78  87  103 121 120 101;
    72  92  95  98  112 100 103 99];

%Q2 = [0 0 0; 1 1 1; 2 2 2];
%Q3 = [0 1; 0 1];

im = imread('LAKE.TIF');
im = im(:,:,1);
original_image_dct = myDCT(im(1:8,1:8), create_mat_dct());
quantized_image_dct = myDCT_dequantization(myDCT_quantization(original_image_dct, Q, 2), Q, 2);

%disp(original_image_dct);
%disp(quantized_image_dct);

original_image =  myIDCT(original_image_dct, create_mat_dct());
quantized_image = myIDCT(quantized_image_dct, create_mat_dct());

disp(original_image);
disp(quantized_image);

figure, imshow(original_image, [0 255]);
figure, imshow(quantized_image, [0 255]);
%disp(RMSE(Q2, Q3));
%disp(My_entropy(original_image));