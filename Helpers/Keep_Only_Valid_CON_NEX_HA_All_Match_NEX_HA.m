fprintf('\nKeeping only valid CON and valid AND matching NEX and HA cells\n');

n_con_0 = eval(sprintf('length(con_%s_%s);',var_str,end_str));
n_nex_0 = eval(sprintf('length(nex_%s_%s);',var_str,end_str));
n_ha_0 = eval(sprintf('length(ha_%s_%s);',var_str,end_str));
n_ua_0 = eval(sprintf('length(ua_%s_%s);',var_str,end_str));

nex_ix = eval(sprintf('intersect(nex_ix_%s_%s,ha_ix_%s_%s)',var_strs{1},end_strs{1},var_strs{1},end_strs{1}));

for i_var = 2:max([length(var_strs) length(end_strs)]),
    
    try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
    try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
    
    nex_ix = eval(sprintf('intersect(nex_ix,intersect(nex_ix_%s_%s,ha_ix_%s_%s))',var_str,end_str,var_str,end_str));
end

ha_ix = nex_ix;
ua_ix = nex_ix;

for i_var = 1:max([length(var_strs) length(end_strs)]),
    
    try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
    try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
    
    con_ix = eval(sprintf('con_ix_%s_%s',var_str,end_str));
    
    switch ndims(eval(sprintf('con_%s_%s',var_str,end_str)))
        
        case 2
            
            eval(sprintf('con_%s_%s = con_%s_%s(:,con_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s = nex_%s_%s(:,nex_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s = ha_%s_%s(:,ha_ix);',var_str,end_str,var_str,end_str));
            if pars.read.ua_flag; eval(sprintf('ua_%s_%s = ua_%s_%s(:,ua_ix);',var_str,end_str,var_str,end_str)); end
            
        case 3
            
            eval(sprintf('con_%s_%s = con_%s_%s(:,:,con_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s = nex_%s_%s(:,:,nex_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s = ha_%s_%s(:,:,ha_ix);',var_str,end_str,var_str,end_str));
            if pars.read.ua_flag; eval(sprintf('ua_%s_%s = ua_%s_%s(:,:,ua_ix);',var_str,end_str,var_str,end_str)); end
            
        case 4
            
            eval(sprintf('con_%s_%s = con_%s_%s(:,:,:,con_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s = nex_%s_%s(:,:,:,nex_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s = ha_%s_%s(:,:,:,ha_ix);',var_str,end_str,var_str,end_str));
            if pars.read.ua_flag; eval(sprintf('ua_%s_%s = ua_%s_%s(:,:,:,ua_ix);',var_str,end_str,var_str,end_str)); end
            
        case 5
            
            eval(sprintf('con_%s_%s = con_%s_%s(:,:,:,:,con_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('nex_%s_%s = nex_%s_%s(:,:,:,:,nex_ix);',var_str,end_str,var_str,end_str));
            eval(sprintf('ha_%s_%s = ha_%s_%s(:,:,:,:,ha_ix);',var_str,end_str,var_str,end_str));
            if pars.read.ua_flag; eval(sprintf('ua_%s_%s = ua_%s_%s(:,:,:,:,ua_ix);',var_str,end_str,var_str,end_str)); end
            
    end
    
    clear ix0
    
    dates =  eval(sprintf('con_dates_%s_%s',var_str,end_str));
    
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
    
    eval(sprintf('con_ix0_%s_%s = ix0(con_ix);',var_str,end_str));
    
    
    clear ix0
    
    dates =  eval(sprintf('nex_dates_%s_%s',var_str,end_str));
    
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
    
    eval(sprintf('nex_ix0_%s_%s = ix0(nex_ix);',var_str,end_str));
    
    
    clear ix0
    
    dates =  eval(sprintf('ha_dates_%s_%s',var_str,end_str));
    
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
    
    eval(sprintf('ha_ix0_%s_%s = ix0(ha_ix);',var_str,end_str));
    
    if pars.read.ua_flag,
        
        clear ix0
        
        dates =  eval(sprintf('ua_dates_%s_%s',var_str,end_str));
        
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
        
        eval(sprintf('ua_ix0_%s_%s = ix0(ua_ix);',var_str,end_str));
        
    end
    
    eval(sprintf('con_blocks_%s_%s = con_blocks_%s_%s(:,con_ix);',var_str,end_str,var_str,end_str));
    eval(sprintf('nex_blocks_%s_%s = nex_blocks_%s_%s(:,nex_ix);',var_str,end_str,var_str,end_str));
    eval(sprintf('ha_blocks_%s_%s = ha_blocks_%s_%s(:,ha_ix);',var_str,end_str,var_str,end_str));
    if pars.read.ua_flag; eval(sprintf('ua_blocks_%s_%s = ua_blocks_%s_%s(:,ua_ix);',var_str,end_str,var_str,end_str)); end
    
    eval(sprintf('con_dates_%s_%s = con_dates_%s_%s(:,con_ix);',var_str,end_str,var_str,end_str));
    eval(sprintf('nex_dates_%s_%s = nex_dates_%s_%s(:,nex_ix);',var_str,end_str,var_str,end_str));
    eval(sprintf('ha_dates_%s_%s = ha_dates_%s_%s(:,ha_ix);',var_str,end_str,var_str,end_str));
    if pars.read.ua_flag; eval(sprintf('ua_dates_%s_%s = ua_dates_%s_%s(:,ua_ix);',var_str,end_str,var_str,end_str)); end
    
    eval(sprintf('con_ix_%s_%s = con_ix;',var_str,end_str));
    eval(sprintf('nex_ix_%s_%s = nex_ix;',var_str,end_str));
    eval(sprintf('ha_ix_%s_%s = ha_ix;',var_str,end_str));
    if pars.read.ua_flag; eval(sprintf('ua_ix_%s_%s = ua_ix;',var_str,end_str)); end
    
end
% end

n_con = length(con_ix);
n_nex = length(nex_ix);
n_ha = length(ha_ix);
n_ua = length(ua_ix);

fprintf('\nKept data for %d/%d, %d/%d, %d/%d, and %d/%d cells\n',n_con,n_con_0,n_nex,n_nex_0,n_ha,n_ha_0,n_ua,n_ua_0);

for i_var = 1:max([length(var_strs) length(end_strs)]),
    
    try;var_str = var_strs{i_var};catch;var_str = var_strs{end};end
    try;end_str = end_strs{i_var};catch;end_str = end_strs{end};end
    
    temp = eval(sprintf('reshape(con_%s_%s,[],size(con_%s_%s,ndims(con_%s_%s)))',var_str,end_str,var_str,end_str,var_str,end_str));
    nx_con = sum(prod(temp,1)==0)+...
        sum(isnan(prod(temp,1)))+...
        sum(isinf(prod(temp,1)));
    
    temp = eval(sprintf('reshape(nex_%s_%s,[],size(nex_%s_%s,ndims(nex_%s_%s)))',var_str,end_str,var_str,end_str,var_str,end_str));
    nx_nex = sum(prod(temp,1)==0)+...
        sum(isnan(prod(temp,1)))+...
        sum(isinf(prod(temp,1)));
    
    temp = eval(sprintf('reshape(ha_%s_%s,[],size(ha_%s_%s,ndims(ha_%s_%s)))',var_str,end_str,var_str,end_str,var_str,end_str));
    nx_ha = sum(prod(temp,1)==0)+...
        sum(isnan(prod(temp,1)))+...
        sum(isinf(prod(temp,1)));
    
    temp = eval(sprintf('reshape(ua_%s_%s,[],size(ua_%s_%s,ndims(ua_%s_%s)))',var_str,end_str,var_str,end_str,var_str,end_str));
    nx_ua = sum(prod(temp,1)==0)+...
        sum(isnan(prod(temp,1)))+...
        sum(isinf(prod(temp,1)));
    
    fprintf('Zeros/NaNs/Infs in %d/%d, %d/%d, %d/%d, and %d/%d cells for variable %d\n',nx_con,n_con,nx_nex,n_nex,nx_ha,n_ha,nx_ua,n_ua,i_var);
    
end

fprintf('\n')