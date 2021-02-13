[n_bins,n_classes,n_trials,n_cells] = size(R0);
R_mean = mean(R0,3);
temp = reshape(permute(R_mean,[4 1 2 3]),n_cells,[]);

[SVEXP,SFEAT,SCOEF,~,SPROJ] = SVD_New_Basis(temp);

close
