[n_bins,n_classes,n_trials,n_cells] = size(R0);
R_mean = squeeze(mean(R0,3));
temp = reshape(R_mean,n_bins,[]);

if pars.lowD.basis_tdim,
    [TVEXP,TFEAT,TCOEF,~,TPROJ] = SVD_New_Basis(temp,pars.lowD.basis_tdim);
else
    [TVEXP,TFEAT,TCOEF,~,TPROJ] = SVD_New_Basis(temp);
end
close
