max_diff = pars.read.successive_max_diff;

fprintf('\nKeeping only cells with successive blocks <= %d apart across all variables\n',max_diff);

if Check_UA_Flag,
    types = {'con','nex','ha','ua'};
else
    types = {'con','nex','ha'};
end

for i_type = 1:length(types),
    
    this_type = types{i_type};
    
    eval(sprintf('n_%s_0 = length(%s_ix_%s_%s);',this_type,this_type,var_strs{1},end_strs{1}));
    
    eval(sprintf('%s_blocks = %s_blocks_%s_%s;',this_type,this_type,var_strs{1},end_strs{1}));
    
    for i_var = 2:max([length(var_strs) length(end_strs)]),
        
        try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
        try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
        
        eval(sprintf('%s_blocks = cat(1,%s_blocks,%s_blocks_%s_%s);',this_type,this_type,this_type,var_str,end_str));
        
    end
    
    eval(sprintf('%s_ix = zeros(1,length(%s_blocks));',this_type,this_type));
    
    for i_cell = 1:eval(sprintf('length(%s_blocks)',this_type)),
        eval(sprintf('temp = %s_blocks(:,i_cell);',this_type));
        if length(temp(~isnan(temp)))>1,
            eval(sprintf('%s_ix(i_cell) = max(abs(diff(temp(~isnan(temp)))))<=max_diff;',this_type));
        end
    end
    
    eval(sprintf('%s_ix = find(%s_ix);',this_type,this_type));
    
    for i_var = 1:max([length(var_strs) length(end_strs)]),
        
        try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
        try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
        
        eval(sprintf('%s_ix_%s_%s = intersect(%s_ix,%s_ix_%s_%s);',this_type,var_str,end_str,this_type,this_type,var_str,end_str));
        
        eval(sprintf('n_%s = length(%s_ix_%s_%s);',this_type,this_type,var_str,end_str));
        
    end
end

fprintf('Removed ');

for i_type = 1:length(types),
    
    this_type = types{i_type};
    
    eval(sprintf('fprintf(''%%d, '',n_%s_0-n_%s);',this_type,this_type));
    
end

fprintf('cells\n');


