try
    existing_results = whos('-file',sprintf('%s\\%s.mat',out_dir,date_1),'dummy');
    
    for i_var = 1:length(out_vars),
        existing_results(end+1) = whos('-file',sprintf('%s\\%s.mat',out_dir,date_1),sprintf('%s_%s',out_vars{i_var},eval(var_name_str)));
    end
catch
    existing_results = [];
end
