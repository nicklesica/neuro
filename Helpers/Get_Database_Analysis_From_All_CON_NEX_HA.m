for i_var = 1:max([length(var_name_strs),length(var_strs),length(end_strs),length(dir_strs)]),
    
    try;dir_str = dir_strs{i_var};catch;dir_str = dir_strs{end};end
    try;var_name_str = var_name_strs{i_var};catch;var_name_str = var_name_strs{end};end
    try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
    try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
    
    eval(sprintf('temp = load(''%s\\Nick\\Other\\Database_Analysis\\%s\\%s.mat'',''con_%s_1'');',...
        dropbox_dir,dir_str,var_name_str,var_str));
    
    eval(sprintf('con_%s_%s = squeeze(temp.con_%s_1(%s));',var_str,end_str,var_str,ix_str));
    
    eval(sprintf('temp = load(''%s\\Nick\\Other\\Database_Analysis\\%s\\%s.mat'',''nex_%s_1'');',...
        dropbox_dir,dir_str,var_name_str,var_str));
    
    eval(sprintf('nex_%s_%s = squeeze(temp.nex_%s_1(%s));',var_str,end_str,var_str,ix_str));
    
    eval(sprintf('temp = load(''%s\\Nick\\Other\\Database_Analysis\\%s\\%s.mat'',''ha_%s_1'');',...
        dropbox_dir,dir_str,var_name_str,var_str));
    
    eval(sprintf('ha_%s_%s = squeeze(temp.ha_%s_1(%s));',var_str,end_str,var_str,ix_str));
    
    if length(strfind(var_name_str,'62')) & pars.read.ua_flag,
        
        eval(sprintf('temp = load(''%s\\Nick\\Other\\Database_Analysis\\%s\\%s.mat'',''nex_%s_1'');',...
            dropbox_dir,dir_str,strrep(var_name_str,'62','83'),var_str));
        
        eval(sprintf('ua_%s_%s = squeeze(temp.nex_%s_1(%s));',var_str,end_str,var_str,ix_str));
        
    end
end
