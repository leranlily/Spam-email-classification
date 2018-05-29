function xo  = z_normalization (xi)

[row, col] =  size (xi);
xo = zeros (row, col);
sum = zeros (col, 1);
ave = zeros (col, 1);
var = zeros (col, 1);

for i = 1 : col
    for j = 1 : row
        sum(i) = sum(i) + xi(j, i);
    end
    ave(i) = sum(i) / row;
    
    for j = 1 : row
    var(i)= var(i) + (xi(j, i) - ave(i)) ^ 2;
    end
   
    var(i) = var(i) / row;
end

for i = 1 : col
    for j = 1 : row
        xo(j, i) =  (xi(j, i) - ave(i))/(var(i) ^ 0.5);
    end
end
end
