function matrix = create_mat_dct()
matrix_temp = zeros(8,8);
N = 8;
for x = 1:8
    for y = 1:8
        ang = cos((2.*pi.*(2.*y+1).*x)./(2.*N));
        r = 0;
        if x == 0
            r = sqrt(1./N);
        else
            r = sqrt(2./N); 
        end
        matrix_temp(x,y) = r*ang;
    end
end
matrix = matrix_temp;
end