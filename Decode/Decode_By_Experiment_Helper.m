PC = NaN(n_taus,pars.decode.pops,length(pars.decode.knn),length(pars.decode.cells));
CM = NaN(pars.n_classes,pars.n_classes,n_taus,pars.decode.pops,length(pars.decode.knn),length(pars.decode.cells));
F1 = NaN(pars.n_classes,n_taus,pars.decode.pops,length(pars.decode.knn),length(pars.decode.cells));

for i_cells = 1:length(pars.decode.cells),
    
    if pars.decode.cells(i_cells) <= n_cells,
        
        switch pars.decode.type
            
            case 'KNN'
                
                cat_vec = reshape(repmat(1:pars.n_classes,pars.n_trials,1),[],1);
                
                for i_pop = 1:pars.decode.pops,
                    
                    fprintf('.');
                    
                    ix = randperm(length(IXA),pars.decode.cells(i_cells));
                    
                    dist_new = sum(dist(:,:,:,IXA(ix)),4);
                    
                    for i_knn = 1:length(pars.decode.knn),
                        
                        [PC(:,i_pop,i_knn,i_cells),~,CM(:,:,:,i_pop,i_knn,i_cells)] = Decode_From_Dist_KNN(dist_new,cat_vec,pars.decode.knn(i_knn));
                        
                        for i_tau = 1:size(dist_new,3),
                            F1(:,i_tau,i_pop,i_knn,i_cells) = Get_F1_From_Confusion_Matrix(CM(:,:,i_tau,i_pop,i_knn,i_cells));
                        end
                    end
                end
                
            case 'SVM'
                
                cat_vec = repmat(1:n_classes,1,n_trials);
                
                for i_pop = 1:pars.decode.pops,
                    
                    fprintf('.');
                    
                    ix = randperm(length(IXA),pars.decode.cells(i_cells));
                    
                    r_new = R(:,:,:,IXA(ix));
                    
                    mdl = fitcecoc(reshape(permute(r_new,[1 4 2 3]),n_bins*pars.decode.cells(i_cells),[])',cat_vec,'CrossVal','on');
                    
                    PC(1,i_pop,1,i_cells) = 100*(1-kfoldLoss(mdl));
                    
                    guess = kfoldPredict(mdl);
                    
                    CM(:,:,:,i_pop,1,i_cells) = hist2(cat_vec,guess,1:n_classes,1:n_classes);
                    
                    F1(:,:,i_pop,1,i_cells) = Get_F1_From_Confusion_Matrix(CM(:,:,:,i_pop,i_cells));
                    
                end
        end
    end
end

fprintf('\n')

CM = squeeze(nanmean(CM,4));
