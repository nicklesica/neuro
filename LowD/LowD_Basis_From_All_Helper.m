[n_bins,n_classes,n_trials,n_cells] = size(R0);
R_mean = squeeze(mean(R0,3));
temp = reshape(R_mean,n_bins,[]);

[TVEXP,TFEAT] = SVD_New_Basis(temp,pars.lowD.tdim);
close
