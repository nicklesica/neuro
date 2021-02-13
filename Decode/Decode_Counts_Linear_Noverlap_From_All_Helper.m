max_decode_pops = floor(size(counts,3)/min(pars.decode_cells));

PC = NaN(1,max_decode_pops,length(pars.decode_knn),length(pars.decode_cells));
CM = NaN(pars.n_classes,pars.n_classes,1,max_decode_pops,length(pars.decode_knn),length(pars.decode_cells));
F1 = NaN(pars.n_classes,1,max_decode_pops,length(pars.decode_knn),length(pars.decode_cells));

for i_cells = 1:length(pars.decode_cells),
    
    decode_pops = floor(size(counts,3)/pars.decode_cells(i_cells));
    
    ix0 = randperm(size(counts,3));
    
    for i_pop = 1:decode_pops,
        
        fprintf('.');
        
        ix = ix0((i_pop-1)*pars.decode_cells(i_cells)+[1:pars.decode_cells(i_cells)]);
        
        counts_new = counts(:,:,ix);
        
        for i_knn = 1:length(pars.decode_knn),
            for i_tau = 1;%:size(counts_new,3),
                
                [PC(i_tau,i_pop,i_knn,i_cells),CM(:,:,i_tau,i_pop,i_knn,i_cells)] = Decode_From_Counts_Linear(counts_new);
                
                F1(:,i_tau,i_pop,i_knn,i_cells) = Get_F1_From_Confusion_Matrix(CM(:,:,i_tau,i_pop,i_knn,i_cells));
                
            end
        end
    end
    
    fprintf('\n');
    
end

CM = squeeze(mean(CM,4));