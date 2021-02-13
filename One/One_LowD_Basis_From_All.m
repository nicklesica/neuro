function One_LowD_Basis_From_All(sound_1,date_list_1,pars)

%% Setup - edit this
out_dir_name = 'LowD_Basis_From_All';
out_vars = {'TVEXP','TFEAT'};

%%
var_name_str = 'sound_1';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

out_dir = sprintf('%s_%s_%s',out_dir,pars.p_type,pars.r_name);

mkdir(out_dir)

Make_Out_Var_String_CON_NEX_HA

%% Get R
var_str = strcat(pars.r_name,pars.p_type);

dir_str = sprintf('Rearranged_Responses');

just_these_dates = date_list_1;

end_str = '1';

temp = var_name_str;
var_name_str = eval(var_name_str);
Get_Database_Analysis_CON_NEX_HA
Keep_Only_Valid_CON_NEX_HA
var_name_str = temp;

R = eval(sprintf('con_%s_%s',var_str,end_str));
R = Rebin_Response(R,pars.lowD.rebin);
con_R_1 = R;

R = eval(sprintf('nex_%s_%s',var_str,end_str));
R = Rebin_Response(R,pars.lowD.rebin);

nex_R_1 = R;

R = eval(sprintf('ha_%s_%s',var_str,end_str));
R = Rebin_Response(R,pars.lowD.rebin);
ha_R_1 = R;

%%
n_cells = [size(con_R_1,4) size(nex_R_1,4) size(ha_R_1,4)]

%CON
R0 = con_R_1;

LowD_Basis_From_All_Helper

Helper_Rename_Results

for i_var = 1:length(out_vars),
    eval(sprintf('con_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
end

%NEX
R0 = nex_R_1;

LowD_Basis_From_All_Helper

Helper_Rename_Results

for i_var = 1:length(out_vars),
    eval(sprintf('nex_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
end

%HA
R0 = ha_R_1;

LowD_Basis_From_All_Helper

Helper_Rename_Results

for i_var = 1:length(out_vars),
    eval(sprintf('ha_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
end

if exist(sprintf('%s\\%s.mat',out_dir,eval(var_name_str))),
    eval(sprintf('save(''%s\\%s.mat'',%s,''-append'');',out_dir,eval(var_name_str),out_var_str));
else
    eval(sprintf('save(''%s\\%s.mat'',%s);',out_dir,eval(var_name_str),out_var_str));
end

