max_decode_pops = floor(size(dist,4)/min(pars.decode_cells));

PCCLASS = NaN(pars.n_classes,size(dist,3),max_decode_pops,length(pars.decode_knn),length(pars.decode_cells));

for i_cells = 1:length(pars.decode_cells),
    
    fprintf('.');
    
    decode_pops = floor(size(dist,4)/pars.decode_cells(i_cells));
    
    ix0 = randperm(size(dist,4));
    
    for i_class = 1:pars.n_classes,
        
        dist_new = dist([(i_class-1)*pars.n_trials+1:i_class*pars.n_trials end-pars.n_trials+1:end],...
            [(i_class-1)*pars.n_trials+1:i_class*pars.n_trials end-pars.n_trials+1:end],:,:);
        
        for i_pop = 1:decode_pops,
            
            ix = ix0((i_pop-1)*pars.decode_cells(i_cells)+[1:pars.decode_cells(i_cells)]);
            
            dist_new_2 = sum(dist_new(:,:,:,ix),4);
            
            for i_knn = 1:length(pars.decode_knn),
                for i_tau = 1:size(dist_new_2,3),
                    
                    PCCLASS(i_class,i_tau,i_pop,i_knn,i_cells) = Decode_From_Dist_KNN(dist_new_2,cat_vec,pars.decode_knn(i_knn));
                    
                end
            end
        end
    end
end

PC = mean(PCCLASS);
PC = reshape(PC,size(PC,2),size(PC,3),size(PC,4),size(PC,5));