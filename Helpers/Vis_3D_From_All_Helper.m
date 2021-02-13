[n_bins,n_classes,n_trials,n_cells] = size(R0);
R_mean = squeeze(mean(R0,3));
temp = reshape(R_mean,n_bins,[]);

[~,~,~,recon] = SVD_New_Basis(temp,3);
close

recon = reshape(recon,n_bins,n_classes,n_cells);
recon = reshape(recon,n_bins*n_classes,n_cells);

recon(1:n_bins:end) = 0;
recon(2:n_bins:end) = 0;

[~,~,~,~,proj] = SVD_New_Basis(recon,3);
close

R3D = reshape(proj,n_bins,n_classes,[]);
