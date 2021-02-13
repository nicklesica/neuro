%% Rename results
for i_var = 1:length(out_vars),
    eval(sprintf('%s_%s = %s;',out_vars{i_var},eval(var_name_str),out_vars{i_var}));
end

try
    if two_sound_flag,
        eval(sprintf('BLK_%s = [BLK_%s;BLK_%s];',eval(var_name_str),sound_1,sound_2));
        eval(sprintf('BLK_%s(:,setdiff(1:size(BLK_%s,2),IXA)) = NaN;',eval(var_name_str),eval(var_name_str)));
        eval(sprintf('clear BLK_%s BLK_%s',sound_1,sound_2));
    end
end