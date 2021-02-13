function [pc,pc_sig] = Decode_From_Counts_TG(counts,pars,pars_shuff)
% Inputs:
% counts    - a matrix of spike counts (n_stim x n_trials x n_cells)
% pars      - a matrix of truncated Gaussian parameters estimated from actual spike counts (3 x n_stim x n_cells)
%             with parameters mean, var, and scaling factor
% pars_shuff - a matrix of truncated Gaussian parameters estimated from shuffled spike counts (3 x n_stim x n_cells x n_shuff)
%
% Outputs:
% pc        - the percent correct decoding
% pc_sig     - the pc measured in standard devs above shuffled mean

[n_stim,n_trials,n_cells] = size(counts);

pred = zeros(n_stim,n_trials);

if nargin>2,
    
    n_shuff = size(pars_shuff,ndims(pars_shuff));
    pred_shuff = zeros(n_stim,n_trials,n_shuff);
    
end

pdist = @(bins,mu,sigma,sf) normpdf(bins,mu,sigma)./sf;

% Assume truncated Gaussian counts
for i_trial = 1:n_trials,
    for i_stim = 1:n_stim,
        
        p = 0;
        
        for i_stim_2 = 1:n_stim,
            p(i_stim_2) = sum(log(pdist(squeeze(counts(i_stim,i_trial,:)),squeeze(pars(1,i_stim_2,:)),squeeze(pars(2,i_stim_2,:)),squeeze(pars(3,i_stim_2,:)))));
        end
        
        temp = find(p==max(p));
        temp = temp(randperm(length(temp)));
        pred(i_stim,i_trial) = temp(1);
    end
end

%Calculate percent correct
pc = 100*sum(reshape(pred',[],1)==reshape(repmat([1:n_stim]',1,n_trials)',[],1))/prod(size(pred));

if nargin>2,
    
    r_shuff = zeros(n_stim,n_trials,n_cells,n_shuff);
    
    for i_shuff = 1:n_shuff,
        for i_cell = 1:n_cells,
            temp = counts(:,:,i_cell);
            r_shuff(:,:,i_cell,i_shuff) = reshape(temp(randperm(prod(size(temp)))),n_stim,n_trials);
        end
    end
    
    for i_trial = 1:n_trials,
        for i_stim = 1:n_stim,
            
            p = zeros(n_stim,n_shuff);
            
            for i_stim_2 = 1:n_stim,
                if n_cells>1,
                    p(i_stim_2,:) = sum(log(pdist(squeeze(r_shuff(i_stim,i_trial,:,:)),squeeze(pars_shuff(1,i_stim_2,:,:)),squeeze(pars_shuff(2,i_stim_2,:,:)),squeeze(pars_shuff(3,i_stim_2,:,:)))));
                else
                    p(i_stim_2,:) = log(pdist(squeeze(r_shuff(i_stim,i_trial,:,:)),squeeze(pars_shuff(1,i_stim_2,:,:)),squeeze(pars_shuff(2,i_stim_2,:,:)),squeeze(pars_shuff(3,i_stim_2,:,:))));
                end
            end
            
            [~,pred_shuff(i_stim,i_trial,:)] = max(p,[],1);
        end
    end
    
    for i_shuff = 1:n_shuff,
        pc_sig(i_shuff) = 100*sum(reshape(pred_shuff(:,:,i_shuff)',[],1)==reshape(repmat([1:n_stim]',1,n_trials)',[],1))/prod(size(pred_shuff(:,:,i_shuff)));
    end
    
    pc_sig = (pc-mean(pc_sig))/std(pc_sig);
    
end