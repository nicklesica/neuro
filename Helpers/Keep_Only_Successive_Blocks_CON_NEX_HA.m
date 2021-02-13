max_diff = pars.read.successive_max_diff;

n_con0 = eval(sprintf('length(con_ix_%s_%s);',var_str,end_str));
n_nex0 = eval(sprintf('length(nex_ix_%s_%s);',var_str,end_str));
n_ha0 = eval(sprintf('length(ha_ix_%s_%s);',var_str,end_str));

eval(sprintf('con_ix_%s_%s = find(diff(con_blocks_%s_%s)<=max_diff);',var_str,end_str,var_str,end_str));
eval(sprintf('nex_ix_%s_%s = find(diff(nex_blocks_%s_%s)<=max_diff);',var_str,end_str,var_str,end_str));
eval(sprintf('ha_ix_%s_%s = find(diff(ha_blocks_%s_%s)<=max_diff);',var_str,end_str,var_str,end_str));

n_con = eval(sprintf('length(con_ix_%s_%s);',var_str,end_str));
n_nex = eval(sprintf('length(nex_ix_%s_%s);',var_str,end_str));
n_ha = eval(sprintf('length(ha_ix_%s_%s);',var_str,end_str));

fprintf('Removed %d/%d, %d/%d, and %d/%d cells because of non-successive blocks\n',...
    n_con0-n_con,n_con0,n_nex0-n_nex,n_nex0,n_ha0-n_ha,n_ha0);
