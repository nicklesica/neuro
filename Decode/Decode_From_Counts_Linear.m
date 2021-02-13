function [pc,cm] = Decode_From_Counts_Linear(counts,type);

if nargin < 2,
    type = 'linear';
end

% counts should be n_classes x n_trials x n_cells

[n_classes,n_trials,n_cells] = size(counts);

guess = zeros(n_classes,n_trials);

for i_trial = 1:n_trials,
    
    sample = squeeze(counts(:,i_trial,:));
    training = reshape(counts(:,setdiff(1:n_trials,i_trial),:),[],n_cells);
    class = repmat([1:n_classes]',n_trials-1,1);
    
    try
        guess(:,i_trial) = classify(sample,training,class);
    catch
        ix = find(~sum(training)); %Find rows that are all zeros and add a tiny bit to one column
        for i = 1:length(ix),
            training(randi(n_classes,1),ix(i)) = 1e-2;
        end
        try
            guess(:,i_trial) = classify(sample,training,class,type);
        catch
            keyboard
        end
    end
end

cat_vec = repmat([1:n_classes]',n_trials,1);

cm  = hist2(cat_vec,guess(:),1:n_classes,1:n_classes);
pc = Calc_Percent_Correct_From_Confusion_Matrix(cm)';