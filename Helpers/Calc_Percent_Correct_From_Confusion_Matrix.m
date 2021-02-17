function [pc,pc_max,i_max] = Calc_Percent_Correct_From_Confusion_Matrix(cm)

n_taus = size(cm,3);

for i_tau=1:n_taus,
    
    pc(i_tau) = 100*sum(diag(cm(:,:,i_tau)))/sum(sum(cm(:,:,i_tau)));
    
end

[pc_max,i_max] = max(pc);
