out_var_str = sprintf('''con_%s_*''',out_vars{1});

for i_var = 2:length(out_vars),
    out_var_str = sprintf('%s,''con_%s_*''',out_var_str,out_vars{i_var});
end

for i_var = 1:length(out_vars),
    out_var_str = sprintf('%s,''nex_%s_*''',out_var_str,out_vars{i_var});
end

for i_var = 1:length(out_vars),
    out_var_str = sprintf('%s,''ha_%s_*''',out_var_str,out_vars{i_var});
end