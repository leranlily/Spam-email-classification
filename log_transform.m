function xo = log_transform (xi)

[row, col] =  size (xi);
xo = zeros (row, col);

for i = 1 : row
    for j = 1 : col
        xo(i, j) = log(xi(i, j) + 0.1);
    end
end
end