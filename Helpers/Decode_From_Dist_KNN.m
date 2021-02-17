function [pc,pc_shuff,cm,cm_shuff] = Decode_From_Dist_KNN(dist,cat_vec,k,n_shuff,tie_breaker);

if nargin < 4,
    n_shuff = 32;
end

if nargin < 3,
    k = 1;
end

% input distance matrix can have a third dimension ...

% tie_breaker = min(min(min(dist(find(dist)))))/1000;
% if isempty(tie_breaker),
%     tie_breaker = 1;
% end

dist = NaN_Diagonals_In_3D_Matrix(dist);

if any(dist),
    
    temp = abs(diff(dist(:)));
    
    if nargin < 5,
        tie_breaker = 0.01*min(temp(temp>0))*randn(size(dist));
    else
        temp = tie_breaker(:);
        %         temp = temp(randperm(length(temp)));
        temp = circshift(temp,randi(length(temp)),1);
        tie_breaker = reshape(temp,size(tie_breaker));
    end
    
    dist = dist+tie_breaker;
    
    [dist_sorted,ix] = sort(dist,1);
    %     ix_shuff = Shuffle(ix(1:end-1,:,:));
    
    n_3 = size(dist,3);
    n_cats = length(unique(cat_vec));
    
    cm = zeros(n_cats,n_cats,n_3);
    %     cm_shuff = zeros(n_cats,n_cats,n_3);
    
    guess = cat_vec(squeeze(ix(1:k,:,:)));
    for i_shuff = 1:n_shuff,
        temp = cat_vec(randperm(length(cat_vec)));
        guess_shuff(:,:,:,i_shuff) = temp(squeeze(ix(1:k,:,:)));
    end
    
    if k > 1,
        
        [~,~,temp] = mode(guess);
        clear guess
        sz = size(temp);
        temp = reshape(temp,1,[]);
        guess = zeros(size(temp));
        for i = 1:size(temp,2),
            if length(temp{i})>1,
                guess(i) = temp{i}(randi(length(temp{i})));
            else
                guess(i) = temp{i};
            end
        end
        guess = reshape(guess,sz);
        guess = squeeze(guess);
        
        [~,~,temp] = mode(guess_shuff);
        sz = size(temp);
        temp = reshape(temp,1,[]);
        guess_shuff = zeros(size(temp));
        for i = 1:size(temp,2),
            if length(temp{i})>1,
                guess_shuff(i) = temp{i}(randi(length(temp{i})));
            else
                guess_shuff(i) = temp{i};
            end
        end
        guess_shuff = reshape(guess_shuff,sz);
        guess_shuff = squeeze(guess_shuff);
    end
    
    if size(guess,1)==1,
        guess = guess';
        guess_shuff = permute(guess_shuff,[1 3 2]);
    end
    
    for i_3 = 1:n_3,
        cm(:,:,i_3) = hist2(cat_vec,guess(:,i_3),1:n_cats,1:n_cats);
        for i_shuff = 1:n_shuff,
            cm_shuff(:,:,i_3,i_shuff) = hist2(cat_vec,guess_shuff(:,i_3,i_shuff),1:n_cats,1:n_cats);
        end
    end
    
    pc = Calc_Percent_Correct_From_Confusion_Matrix(cm)';
    for i_shuff = 1:n_shuff,
        pc_shuff(:,i_shuff) = Calc_Percent_Correct_From_Confusion_Matrix(cm_shuff(:,:,:,i_shuff))';
    end
    
else
    pc = 100/length(unique(cat_vec));
    cm = zeros(length(unique(cat_vec)),length(unique(cat_vec)));
    pc_shuff = 100/length(unique(cat_vec));
    cm_shuff = zeros(length(unique(cat_vec)),length(unique(cat_vec)));
end

