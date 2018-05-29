function xo = binarization (xi)

[row, col] =  size (xi);
xo = zeros (row, col);
for i = 1 : row
    for j = 1 : col
        if xi(i, j) > 0
            xo(i, j) = 1;
        else
            xo(i, j) = 0;
        end
    end
end
end
