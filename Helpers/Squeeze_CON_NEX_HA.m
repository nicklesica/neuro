try %in case there are no NEX, or HA
    
    if eval(sprintf('prod(size(con_%s_%s)) == length(con_%s_%s)',var_str,end_str,var_str,end_str)),
        
        eval(sprintf('con_%s_%s = squeeze(con_%s_%s)'';',var_str,end_str,var_str,end_str));
        eval(sprintf('nex_%s_%s = squeeze(nex_%s_%s)'';',var_str,end_str,var_str,end_str));
        eval(sprintf('ha_%s_%s = squeeze(ha_%s_%s)'';',var_str,end_str,var_str,end_str));
        
    else
        
        eval(sprintf('con_%s_%s = squeeze(con_%s_%s);',var_str,end_str,var_str,end_str));
        eval(sprintf('nex_%s_%s = squeeze(nex_%s_%s);',var_str,end_str,var_str,end_str));
        eval(sprintf('ha_%s_%s = squeeze(ha_%s_%s);',var_str,end_str,var_str,end_str));
        
    end
end

