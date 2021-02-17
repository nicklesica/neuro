function out = NaN_Diagonals_In_3D_Matrix(in);

out = in;

for i = 1:size(in,3),
    for j = 1:size(in,1),
        out(j,j,i) = NaN;
    end
end