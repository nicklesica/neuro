max_diff = pars.read.successive_max_diff;

fprintf('Keeping only cells with successive blocks <= %d apart\n',max_diff);

if Check_UA_Flag,
    types = {'con','nex','ha','ua'};
else
    types = {'con','nex','ha'};
end

if eval(sprintf('any(%s_blocks_%s_%s(2,:))',types{1},var_str,end_str)),
    
    for i_type = 1:length(types),
        
        this_type = types{i_type};
        
        eval(sprintf('n_%s_0 = length(%s_ix_%s_%s);',this_type,this_type,var_str,end_str));
        
        eval(sprintf('%s_ix_%s_%s = find(abs(diff(%s_blocks_%s_%s))<=max_diff);',this_type,var_str,end_str,this_type,var_str,end_str));
        
        eval(sprintf('n_%s = length(%s_ix_%s_%s);',this_type,this_type,var_str,end_str));
        
    end
    
    fprintf('Removed ');
    
    for i_type = 1:length(types),
        
        this_type = types{i_type};
        
        eval(sprintf('fprintf(''%%d/%%d, '',n_%s_0-n_%s,n_%s_0);',this_type,this_type,this_type));
        
    end
    
    fprintf(sprintf('cells for variable %d\n',i_var));
    
else
    fprintf('Only one block found for variable %d\n',i_var);
end

