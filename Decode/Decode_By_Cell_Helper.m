
PC = zeros(n_taus,length(pars.decode.knn),n_cells);
PC0 = zeros(n_taus,length(pars.decode.knn),n_cells,pars.decode.n_shuff);
% CM = zeros(pars.n_classes,pars.n_classes,size(dist,3),length(pars.decode.knn),size(dist,4));
% F1 = zeros(pars.n_classes,size(dist,3),length(pars.decode.knn),size(dist,4));

for i_cell = 1:length(IXA),
    
    fprintf('.')
    
    switch pars.decode.type
        
        case 'KNN'
            
            cat_vec = reshape(repmat(1:pars.n_classes,pars.n_trials,1),[],1);
            
            dist_new = dist(:,:,:,IXA(i_cell));
            
            for i_knn = 1:length(pars.decode.knn),
                
                [PC(:,i_knn,IXA(i_cell)),PC0(:,i_knn,IXA(i_cell),:)] = Decode_From_Dist_KNN(dist_new,cat_vec,pars.decode.knn(i_knn),pars.decode.n_shuff);
                
            end
            
        case 'SVM'
            
            cat_vec = repmat(1:n_classes,1,n_trials);
            
            r_new = R(:,:,:,IXA(i_cell));
            
            mdl = fitcecoc(reshape(r_new,n_bins,[])',cat_vec,'CrossVal','on');
            
            PC(1,1,IXA(i_cell)) = 100*(1-kfoldLoss(mdl));
            
            % No PC0 yet ...
    end
end

fprintf('\n')

SIG = PC>(mean(PC0,4)+pars.decode.sig_stds*std(PC0,[],4));
STD0 = std(PC0,[],4);
