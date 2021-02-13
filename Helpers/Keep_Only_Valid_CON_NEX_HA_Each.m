fprintf('\nKeeping only cells with valid data for each variable\n');

if Check_UA_Flag,
types = {'con','nex','ha','ua'};
else
types = {'con','nex','ha'};
end

for i_var = 1:max([length(var_strs) length(end_strs)]),
    
    try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
    try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
    
    for i_type = 1:length(types),
        
        this_type = types{i_type};
        
        eval(sprintf('n_%s_0 = length(%s_ix_%s_%s);',this_type,this_type,var_str,end_str));
        
        if eval(sprintf('n_%s_0',this_type)),
        
        eval(sprintf('%s_ix = %s_ix_%s_%s;',this_type,this_type,var_str,end_str));
        
        switch ndims(eval(sprintf('%s_%s_%s',this_type,var_str,end_str)))
            
            case 2
                
                eval(sprintf('%s_%s_%s = %s_%s_%s(:,%s_ix);',this_type,var_str,end_str,this_type,var_str,end_str,this_type));
                
            case 3
                
                eval(sprintf('%s_%s_%s = %s_%s_%s(:,:,%s_ix);',this_type,var_str,end_str,this_type,var_str,end_str,this_type));
                
            case 4
                
                eval(sprintf('%s_%s_%s = %s_%s_%s(:,:,:,%s_ix);',this_type,var_str,end_str,this_type,var_str,end_str,this_type));
                
            case 5
                
                eval(sprintf('%s_%s_%s = %s_%s_%s(:,:,:,:,%s_ix);',this_type,var_str,end_str,this_type,var_str,end_str,this_type));
                
        end
        
        clear ix0
        
        dates =  eval(sprintf('%s_dates_%s_%s',this_type,var_str,end_str));
       
        n_cells = size(dates,2);
        
        this_date = 0;
        i_cell = 1;
        
        while i_cell <= n_cells,
            if dates(i_cell) ~= this_date,
                this_date = dates(i_cell);
                ix0(i_cell) = 1;
            else
                ix0(i_cell) = ix0(i_cell-1)+1;
            end
            i_cell = i_cell + 1;
        end
        
        eval(sprintf('%s_ix0_%s_%s = ix0(%s_ix);',this_type,var_str,end_str,this_type));
        
        eval(sprintf('%s_blocks_%s_%s = %s_blocks_%s_%s(:,%s_ix);',this_type,var_str,end_str,this_type,var_str,end_str,this_type));
        
        eval(sprintf('%s_dates_%s_%s = %s_dates_%s_%s(:,%s_ix);',this_type,var_str,end_str,this_type,var_str,end_str,this_type));
        
        eval(sprintf('n_%s = length(%s_ix);',this_type,this_type));
        
        else
            
            eval(sprintf('n_%s = 0;',this_type));
            
        end
            
        
    end
    
    fprintf('Kept ');
    
    for i_type = 1:length(types),
        
        this_type = types{i_type};
        
        eval(sprintf('fprintf(''%%d/%%d, '',n_%s,n_%s_0);',this_type,this_type));
        
    end
    
    fprintf(sprintf('cells for variable %d\n',i_var));
    
    
    fprintf('Zeros/NaNs/Infs in ');
    
    for i_type = 1:length(types),
        
        this_type = types{i_type};
        
        temp = eval(sprintf('reshape(%s_%s_%s,[],size(%s_%s_%s,ndims(%s_%s_%s)))',...
            this_type,var_str,end_str,this_type,var_str,end_str,this_type,var_str,end_str));
        
        nx = sum(prod(temp,1)==0)+...
            sum(isnan(prod(temp,1)))+...
            sum(isinf(prod(temp,1)));
        
        eval(sprintf('fprintf(''%%d/%%d, '',nx,n_%s_0);',this_type));
        
    end
    
    fprintf(sprintf('cells for variable %d\n',i_var));
    
end

