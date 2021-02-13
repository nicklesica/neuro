max_decode_pops = floor(size(R,4)/min(pars.decode.cells));

PC = NaN(n_taus,max_decode_pops,length(pars.decode.knn),length(pars.decode.cells));
CM = NaN(pars.n_classes,pars.n_classes,n_taus,max_decode_pops,length(pars.decode.knn),length(pars.decode.cells));
F1 = NaN(pars.n_classes,n_taus,max_decode_pops,length(pars.decode.knn),length(pars.decode.cells));

vars = {'MEAN','VARS','VARN','STDS','STDN','SNR','SNR2','CSIG','CNOISE'};

for i_var = 1:length(vars),
    eval(sprintf('%s = NaN(1,max_decode_pops,length(pars.decode.cells));',vars{i_var}));
end

for i_cells = 1:length(pars.decode.cells),
    
    fprintf('.');
    
    decode_pops = floor(size(R,4)/pars.decode.cells(i_cells));
    
%     ix0 = randperm(size(R,4));
    
    for i_pop = 1:decode_pops,
        
%         ix = ix0((i_pop-1)*pars.decode.cells(i_cells)+[1:pars.decode.cells(i_cells)]);

ix = these_pops{i_cells,i_pop};
        
        try
            dist_new = sum(dist(:,:,:,ix),4);
        end
        
        r_new = R(:,:,:,ix);
        
        if size(R,1) == 1,
            
            [n_bins,n_classes,n_trials,n_cells] = size(r_new);
            
            sig = squeeze(mean(r_new,3));
            
            if ndims(sig) == 2,
                
                sig = permute(sig,[3 1 2]);
                
            end
            
            noise = r_new - repmat(permute(sig,[1 2 4 3]),1,1,n_trials,1);
            
            noise = reshape(noise,n_bins,[],n_cells);
            
            % Signal
            
            VARS0 = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                VARS0(i_bin,:) = var(squeeze(sig(i_bin,:,:)));
                
            end
            
            % Noise
            
            VARN0 = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                VARN0(i_bin,:) = var(squeeze(noise(i_bin,:,:)));
                
            end
            
            % Signal
            
            CSIG0 = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                temp = corr(squeeze(sig(i_bin,:,:)));
                
                CSIG0(i_bin,:) = nanmean(NaN_Diagonals_In_3D_Matrix(temp))';
                
            end
            
            % Noise
            
            CNOISE0 = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                temp = corr(squeeze(noise(i_bin,:,:)));
                
                CNOISE0(i_bin,:) = nanmean(NaN_Diagonals_In_3D_Matrix(temp))';
                
            end
            
            MEAN0 = squeeze(mean(sig,2))';
            
            STDS0 = sqrt(VARS0);
            STDN0 = sqrt(VARN0);
            
            SNR0 = VARS0./VARN0;
            
            SNR20 = STDS0./STDN0;
            
            for i_var = 1:length(vars),
                eval(sprintf('%s(1,i_pop,i_cells) = nanmean(%s0);',vars{i_var},vars{i_var}));
            end
            
        end
        
        switch pars.decode.type
            
            case 'KNN'
                
                cat_vec = reshape(repmat(1:pars.n_classes,pars.n_trials,1),[],1);
                
                for i_knn = 1:length(pars.decode.knn),
                    
                    [PC(:,i_pop,i_knn,i_cells),~,CM(:,:,:,i_pop,i_knn,i_cells)] = Decode_From_Dist_KNN(dist_new,cat_vec,pars.decode.knn(i_knn));
                    
                    for i_tau = 1:size(dist_new,3),
                        F1(:,i_tau,i_pop,i_knn,i_cells) = Get_F1_From_Confusion_Matrix(CM(:,:,i_tau,i_pop,i_knn,i_cells));
                    end
                end
                
            case 'SVM'
                
                cat_vec = repmat(1:n_classes,1,n_trials);
                
                mdl = fitcecoc(reshape(permute(r_new,[1 4 2 3]),n_bins*pars.decode.cells(i_cells),[])',cat_vec,'CrossVal','on');
                
                PC(1,i_pop,1,i_cells) = 100*(1-kfoldLoss(mdl));
                
                guess = kfoldPredict(mdl);
                
                CM(:,:,:,i_pop,1,i_cells) = hist2(cat_vec,guess,1:n_classes,1:n_classes);
                
                F1(:,:,i_pop,1,i_cells) = Get_F1_From_Confusion_Matrix(CM(:,:,:,i_pop,1,i_cells));
                
        end
    end
end

fprintf('\n')

CM = squeeze(nanmean(CM,4));