function rmse_error = RMSE(im1, im2)
x_max = max(size(im1, 1), size(im2, 1));
y_max = max(size(im1, 2), size(im2, 2));
new_im1 = zeros(x_max, y_max);
new_im2 = zeros(x_max, y_max);
for row = 1:x_max
    if row <= size(im1, 1)
        new_im1(row,:) = [im1(row,:), zeros(1, y_max - size(im1,2))];
    else
        new_im1(row,:) = zeros(1, y_max);
    end
    if row <= size(im2 ,1)
        new_im2(row,:) = [im2(row,:), zeros(1, y_max - size(im2,2))];
    else
        new_im2(row,:) = zeros(1, y_max);
    end
end
error = ((new_im1 - new_im2).^2);
tot_error = sum(sum(error));
rmse_error = sqrt(tot_error./(x_max.*y_max));
%rmse_error = sqrt(mean((new_im1 - new_im2).^2));
end