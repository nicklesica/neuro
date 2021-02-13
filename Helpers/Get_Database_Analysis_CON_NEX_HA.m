tic

if exist('pars')
    if isfield(pars,'read')
        if isfield(pars.read,'ua_flag'),
            ua_flag = pars.read.ua_flag;
        else
            ua_flag = 0;
        end
    else
        ua_flag = 0;
    end
else
    ua_flag = 0;
end

fprintf('\nLoading %s from %s for %s\n',var_str,dir_str,var_name_str);

date_list = evalin('base','database_dates_con');

if ~isempty(just_these_dates),
    date_list = intersect(date_list,just_these_dates);
end

if length(date_list),
    
    eval(sprintf('[con_%s_%s,con_ix_%s_%s,con_blocks_%s_%s,con_dates_%s_%s] = Get_Database_Analysis(date_list,''%s'',dir_str,var_str);',...
        var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str,var_name_str));
    
else
    fprintf('No CON dates in specified list\n');
    
    eval(sprintf('con_%s_%s = [];',var_str,end_str));
    eval(sprintf('con_ix_%s_%s = [];',var_str,end_str));
    eval(sprintf('con_blocks_%s_%s = [];',var_str,end_str));
    eval(sprintf('con_dates_%s_%s = [];',var_str,end_str));
end


date_list = evalin('base','database_dates_nex');

if ~isempty(just_these_dates),
    date_list = intersect(date_list,just_these_dates);
end

if length(date_list),
    
    eval(sprintf('[nex_%s_%s,nex_ix_%s_%s,nex_blocks_%s_%s,nex_dates_%s_%s] = Get_Database_Analysis(date_list,''%s'',dir_str,var_str);',...
        var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str,var_name_str));
    
    if ua_flag & length(strfind(var_name_str,'62')),
        
        eval(sprintf('[ua_%s_%s,ua_ix_%s_%s,ua_blocks_%s_%s,ua_dates_%s_%s] = Get_Database_Analysis(date_list,''%s'',dir_str,var_str);',...
            var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str,strrep(var_name_str,'62','83')));
        
    else
        
        eval(sprintf('ua_%s_%s = [];',var_str,end_str));
        eval(sprintf('ua_ix_%s_%s = [];',var_str,end_str));
        eval(sprintf('ua_blocks_%s_%s = [];',var_str,end_str));
        eval(sprintf('ua_dates_%s_%s = [];',var_str,end_str));
        
    end
    
    switch length(find(var_name_str=='_')),
        
        case 6
            
            var_name_str = sprintf('%sha%s',var_name_str(1:end-2),var_name_str(end-1:end));
            
        case 13
            
            ix = find(var_name_str=='_');
            
            var_name_str = sprintf('%sha%s%sha%s',var_name_str(1:ix(7)-3),var_name_str(ix(7)-2:ix(7)-1),...
                var_name_str(ix(7):end-2),var_name_str(end-1:end));
            
        otherwise
            fprintf('Using same variable name for HA\n');
            
    end
    
    eval(sprintf('[ha_%s_%s,ha_ix_%s_%s,ha_blocks_%s_%s,ha_dates_%s_%s] = Get_Database_Analysis(date_list,''%s'',dir_str,var_str);',...
        var_str,end_str,var_str,end_str,var_str,end_str,var_str,end_str,var_name_str));
    
else
    fprintf('No NEX dates in specified list\n');
    
    eval(sprintf('nex_%s_%s = [];',var_str,end_str));
    eval(sprintf('nex_ix_%s_%s = [];',var_str,end_str));
    eval(sprintf('nex_blocks_%s_%s = [];',var_str,end_str));
    eval(sprintf('nex_dates_%s_%s = [];',var_str,end_str));
    
    eval(sprintf('ua_%s_%s = [];',var_str,end_str));
    eval(sprintf('ua_ix_%s_%s = [];',var_str,end_str));
    eval(sprintf('ua_blocks_%s_%s = [];',var_str,end_str));
    eval(sprintf('ua_dates_%s_%s = [];',var_str,end_str));
    
    eval(sprintf('ha_%s_%s = [];',var_str,end_str));
    eval(sprintf('ha_ix_%s_%s = [];',var_str,end_str));
    eval(sprintf('ha_blocks_%s_%s = [];',var_str,end_str));
    eval(sprintf('ha_dates_%s_%s = [];',var_str,end_str));
end


n_con_0 = eval(sprintf('length(con_%s_%s);',var_str,end_str));
n_nex_0 = eval(sprintf('length(nex_%s_%s);',var_str,end_str));
n_ua_0 = eval(sprintf('length(ua_%s_%s);',var_str,end_str));
n_ha_0 = eval(sprintf('length(ha_%s_%s);',var_str,end_str));

n_con = eval(sprintf('length(con_ix_%s_%s);',var_str,end_str));
n_nex = eval(sprintf('length(nex_ix_%s_%s);',var_str,end_str));
n_ua = eval(sprintf('length(ua_ix_%s_%s);',var_str,end_str));
n_ha = eval(sprintf('length(ha_ix_%s_%s);',var_str,end_str));

fprintf('Found data for %d/%d, %d/%d, %d/%d, and %d/%d cells\n',n_con,n_con_0,n_nex,n_nex_0,n_ha,n_ha_0,n_ua,n_ua_0);

fprintf(sprintf('Elapsed time: %d s\n',round(toc)));
