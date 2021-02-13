max_decode_pops = floor(size(R0,4)/min(pars.decode_cells));

PC = NaN(1,max_decode_pops,1,length(pars.decode_cells));
CM = NaN(pars.n_classes,pars.n_classes,1,max_decode_pops,1,length(pars.decode_cells));
F1 = NaN(pars.n_classes,1,max_decode_pops,1,length(pars.decode_cells));

vars = {'MEAN','VARS','VARN','STDS','STDN','SNR','SNR2','CSIG','CNOISE'};

for i_var = 1:length(vars),
    eval(sprintf('%s = NaN(1,max_decode_pops,length(pars.decode_cells));',vars{i_var}));
end

for i_cells = 1:length(pars.decode_cells),
    
    fprintf('.');
    
    decode_pops = floor(size(R0,4)/pars.decode_cells(i_cells));
    
    ix0 = randperm(size(R0,4));
    
    for i_pop = 1:decode_pops,
        
        ix = ix0((i_pop-1)*pars.decode_cells(i_cells)+[1:pars.decode_cells(i_cells)]);
        
        R = R0(:,:,:,ix);
        
        [n_bins,n_classes,n_trials,n_cells] = size(R);
        
        %Find temporal basis
        
        %         temp = reshape(R,n_bins,[]);
        
        R_mean = squeeze(mean(R,3));
        temp = reshape(R_mean,n_bins,[]);
        
        [R_bin_smooth_varexp,R_bin_smooth_features,R_bin_smooth_coeffs,R_bin_smooth_recon,R_bin_smooth_proj] = SVD_New_Basis(temp);%,pars.lowd_tdim);
        close
        
        R_bin_smooth_coeffs = reshape(R_bin_smooth_coeffs,n_classes,n_cells,[]);
        R_bin_smooth_recon = reshape(R_bin_smooth_recon,[],n_classes,n_cells);
        
        % Find spatial basis
        temp = reshape(permute(R_bin_smooth_coeffs,[2 1 3]),n_cells,[]);
        
        [R_cell_smooth_varexp,R_cell_smooth_features,R_cell_smooth_coeffs,R_cell_smooth_recon,R_cell_smooth_proj] = SVD_New_Basis(temp);%,pars.lowd_sdim);
        close
        
        R_cell_smooth_coeffs = reshape(R_cell_smooth_coeffs,n_classes,[],size(R_cell_smooth_coeffs,2));
        R_cell_smooth_recon = permute(reshape(R_cell_smooth_recon,[],n_classes,size(R_cell_smooth_coeffs,2)),[2 1 3]);
        
        % Project onto basis
        temp = reshape(R,n_bins,[]);
        temp = R_bin_smooth_features'*temp;
        temp = reshape(temp,size(temp,1),n_classes,n_trials,n_cells);
        
        %         temp = reshape(temp,[],n_cells)';
        %         temp = R_cell_smooth_features'*temp;
        %         temp = reshape(temp,size(temp,1),[],n_classes,n_trials);
        %         temp = reshape(temp,size(temp,1)*size(temp,2),size(temp,3),size(temp,4));
        %
        %         R_lowD = permute(temp,[2 3 1]);
        
        R_lowD = temp;
        
        % Response parameters
        %         [n_classes,n_trials,n_cells] = size(R_lowD);
        %
        %         sig = squeeze(mean(R_lowD,2));
        %
        %         noise = R_lowD - repmat(permute(sig,[1 3 2]),1,size(R_lowD,2),1);
        %
        %         noise = reshape(noise,[],size(noise,3));
        %
        %         MEAN0 = mean(sig);
        %
        %         VARS0 = var(sig);
        %         VARN0 = var(noise);
        %
        %         STDS0 = var(sig);
        %         STDN0 = var(noise);
        %
        %         SNR0 = var(sig)./var(noise);
        %
        %         SNR20 = std(sig)./std(noise);
        %
        %         CSIG0 = corr(sig);
        %
        %         CSIG0 = nanmean(NaN_Diagonals_In_3D_Matrix(CSIG0))';
        %
        %         CNOISE0 = corr(noise);
        %
        %         CNOISE0 = nanmean(NaN_Diagonals_In_3D_Matrix(CNOISE0))';
        %
        %         for i_var = 1:length(vars),
        %             eval(sprintf('%s(1,i_pop,i_cells) = nanmean(%s0);',vars{i_var},vars{i_var}));
        %         end
        
        % Decode
        %         for i_knn = 1:length(pars.decode_knn),
        %             for i_tau = 1:size(dist_new,3),
        
        d = zeros(n_classes*n_trials,n_classes*n_trials,1,n_cells);
        
        for i_cell = 1:n_cells,
            if sum(reshape(R_lowD(:,:,i_cell)',[],1)),
                
                d(:,:,1,i_cell) = dist(reshape(R_lowD(:,:,:,i_cell),size(R_lowD,1),[]));
                
            end
        end
        
        d = sum(d,4);
        
        cat_vec = repmat([1:n_classes]',n_trials,1);
        
        %         [PC(1,i_pop,1,i_cells),CM(:,:,1,i_pop,1,i_cells)] = Decode_From_Counts_Linear(R_lowD);
        [PC(1,i_pop,1,i_cells),CM(:,:,1,i_pop,1,i_cells)] = Decode_From_Dist_KNN(d,cat_vec,16);
        
        F1(:,1,i_pop,1,i_cells) = Get_F1_From_Confusion_Matrix(CM(:,:,1,i_pop,1,i_cells));
        
        %             end
        %         end
    end
end

CM = squeeze(mean(CM,4));