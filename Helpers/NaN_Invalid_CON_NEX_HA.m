try %in case there are no NEX, or HA
    
    switch ndims(eval(sprintf('con_%s_%s',var_str,end_str)))
        
        case 2
            
            eval(sprintf('con_%s_%s(:,setdiff(1:size(con_%s_%s,ndims(con_%s_%s)),con_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s(:,setdiff(1:size(nex_%s_%s,ndims(nex_%s_%s)),nex_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s(:,setdiff(1:size(ha_%s_%s,ndims(ha_%s_%s)),ha_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            
        case 3
            
            eval(sprintf('con_%s_%s(:,:,setdiff(1:size(con_%s_%s,ndims(con_%s_%s)),con_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s(:,:,setdiff(1:size(nex_%s_%s,ndims(nex_%s_%s)),nex_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s(:,:,setdiff(1:size(ha_%s_%s,ndims(ha_%s_%s)),ha_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            
        case 4
            
            eval(sprintf('con_%s_%s(:,:,:,setdiff(1:size(con_%s_%s,ndims(con_%s_%s)),con_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s(:,:,:,setdiff(1:size(nex_%s_%s,ndims(nex_%s_%s)),nex_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s(:,:,:,setdiff(1:size(ha_%s_%s,ndims(ha_%s_%s)),ha_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            
        case 5
            
            eval(sprintf('con_%s_%s(:,:,:,:,setdiff(1:size(con_%s_%s,ndims(con_%s_%s)),con_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s(:,:,:,:,setdiff(1:size(nex_%s_%s,ndims(nex_%s_%s)),nex_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s(:,:,:,:,setdiff(1:size(ha_%s_%s,ndims(ha_%s_%s)),ha_ix_%s_%s)) = NaN;',var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str));
            
    end
end

