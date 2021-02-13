for i_var = 1:max([length(var_name_strs),length(var_strs),length(end_strs),length(dir_strs)]),
    
    try;dir_str = dir_strs{i_var};catch;dir_str = dir_strs{end};end
    try;var_name_str = var_name_strs{i_var};catch;var_name_str = var_name_strs{end};end
    try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
    try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
    
    eval(sprintf('[db_%s_%s,db_ix_%s_%s,db_blocks_%s_%s,db_dates_%s_%s] = Get_Database_Analysis(date_list,''%s'',dir_str,var_str);',...
        var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str,var_name_str));
    
end
