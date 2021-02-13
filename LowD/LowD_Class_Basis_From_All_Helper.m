[n_bins,n_classes,n_trials,n_cells] = size(R0);
R_mean = mean(R0,3);
temp = reshape(permute(R_mean,[2 1 3 4]),n_classes,[]);

[CVEXP,CFEAT,CCOEF,~,CPROJ] = SVD_New_Basis(temp);
close
