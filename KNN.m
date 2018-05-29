%function KNN
%calculate estimate y using K-nearest Neighbors
function [y] = KNN(Xva, Xtr, ytr, K ,flag)

[row, col] = size(Xtr);

%calculate the distance
diff = repmat(Xva, [row,1]) - Xtr;

if flag ==1
    dis = sqrt(sum(diff.^2,2));
else
    dis = zeros (row, 1);
    for i = 1 :row
        for j = 1 : col
            if diff(i, j) ~= 0
            dis(i) = dis(i) + 1;
            end
        end
    end
end

%sort the distances and find the K smallest
[Ax , Index] = sort(dis, 'ascend');
length = min(K, size(Ax,1));

%calculate y
y = mode(ytr(Index(1: length)));

end