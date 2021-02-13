%% Load responses
try
    
    r_1 = eval(sprintf('R_%s',sound_1));
    
    [n_bins,n_cells] = size(r_1);
    
    if two_sound_flag,
        r_2 = eval(sprintf('R_%s',sound_2));
    end
    
catch
    
    fprintf('R_%s does not exist ...\n',sound_1);
end
