function matrix = create_mat_dct()
matrix_temp = zeros(8,8);
N = 8;
for x = 0:7
    for y = 0:7
        ang = cos((2.*pi.*(2.*y+1).*x)./(4.*N));
        r = 0;
        if x == 0
            r = sqrt(1./N);
        else
            r = sqrt(2./N); 
        end
        matrix_temp(x+1,y+1) = r.*ang;
    end
end
matrix = matrix_temp;
end