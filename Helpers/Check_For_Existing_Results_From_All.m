try
    existing_results = whos('-file',sprintf('%s\\%s.mat',out_dir,sound_1),'dummy');
    
    for i_var = 1:length(out_vars),
        existing_results(end+1) = whos('-file',sprintf('%s\\%s.mat',out_dir,sound_1),sprintf('con_%s_1',out_vars{i_var}));
    end
catch
    existing_results = [];
end
