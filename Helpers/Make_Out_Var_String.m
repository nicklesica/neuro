out_var_str = sprintf('''%s_*''',out_vars{1});

for i_var = 2:length(out_vars),
    out_var_str = sprintf('%s,''%s_*''',out_var_str,out_vars{i_var});
end
