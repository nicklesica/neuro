if max([length(var_strs) length(end_strs)]) ~= max([length(var_name_strs) length(dir_strs) length(var_strs)]),
    fprintf('Something is wrong. Check the string specificiations ...\n\n');
    return
end

for i_var = 1:max([length(var_name_strs),length(var_strs),length(end_strs),length(dir_strs)]),
    
    try;dir_str = dir_strs{i_var};catch;dir_str = dir_strs{end};end
    try;var_name_str = var_name_strs{i_var};catch;var_name_str = var_name_strs{end};end
    try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
    try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
    
    Get_Database_Analysis_CON_NEX_HA
    
    if pars.read.sparse_to_full,
        Convert_Sparse_To_Full_CON_NEX_HA
    end
    
    if pars.read.keep_only_successive == 1
        Keep_Only_Successive_Blocks_CON_NEX_HA_Each
    end
end

if pars.read.keep_only_successive == 2,
    Keep_Only_Successive_Blocks_CON_NEX_HA_All
end

switch pars.read.keep_only_valid
    case 1
        Keep_Only_Valid_CON_NEX_HA_Each
        
    case 2
        Keep_Only_Valid_CON_NEX_HA_All
        
    case 3
        Keep_Only_Valid_CON_NEX_HA_All_Match_NEX_HA
end
