function One_Vis3D_From_All(sound_1,date_list_1,pars)

%% Setup - edit this
out_dir_name = 'Vis_3D_From_All';
out_vars = {'R3D'};

%%
var_name_str = 'sound_1';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

out_dir = sprintf('%s_%s_%s',out_dir,pars.p_type,pars.r_name);

mkdir(out_dir)

Make_Out_Var_String_CON_NEX_HA

%% Get R
just_these_dates = date_list_1;
var_strs = {'R0'};
dir_strs = {'Rearranged_Responses'};
end_strs = {'1'};
temp_str = var_name_str;
var_name_strs = {eval(var_name_str)};

dir_str = dir_strs{1};
var_name_str = var_name_strs{1};
var_str = var_strs{1};
end_str = end_strs{1};

Get_Database_Analysis_CON_NEX_HA
Keep_Only_Valid_CON_NEX_HA_Each
var_name_str = temp_str;

%CON
R = eval(sprintf('con_%s_%s',var_str,end_str));

switch pars.p_type
    case {'CV12','VC8'}
        R = reshape(R,size(R,1),size(R,2),size(R,3)*size(R,4),size(R,5));
        
end

R = Rebin_Response(R,pars.vis3D.rebin);

dt = (pars.rearrange0.rebin/pars.fs)*pars.vis3D.rebin;

ix_bins = [find(dt:dt:1>pars.vis3D.t_min,1):...
    find(dt:dt:1>pars.vis3D.t_max,1)];

R = R(ix_bins,pars.vis3D.ix_classes,:,:);

con_R_1 = R;

%NEX
R = eval(sprintf('nex_%s_%s',var_str,end_str));

switch pars.p_type
    case {'CV12','VC8'}
        R = reshape(R,size(R,1),size(R,2),size(R,3)*size(R,4),size(R,5));
        
end

R = Rebin_Response(R,pars.vis3D.rebin);

R = R(ix_bins,pars.vis3D.ix_classes,:,:);

nex_R_1 = R;

%HA
R = eval(sprintf('ha_%s_%s',var_str,end_str));

switch pars.p_type
    case {'CV12','VC8'}
        R = reshape(R,size(R,1),size(R,2),size(R,3)*size(R,4),size(R,5));
        
end

R = Rebin_Response(R,pars.vis3D.rebin);

R = R(ix_bins,pars.vis3D.ix_classes,:,:);

ha_R_1 = R;

%%
n_cells = [size(con_R_1,4) size(nex_R_1,4) size(ha_R_1,4)]

%CON
R0 = con_R_1;

Vis_3D_From_All_Helper

Helper_Rename_Results

for i_var = 1:length(out_vars),
    eval(sprintf('con_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
end

%NEX
R0 = nex_R_1;

Vis_3D_From_All_Helper

Helper_Rename_Results

for i_var = 1:length(out_vars),
    eval(sprintf('nex_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
end

%HA
R0 = ha_R_1;

Vis_3D_From_All_Helper

Helper_Rename_Results

for i_var = 1:length(out_vars),
    eval(sprintf('ha_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
end

if exist(sprintf('%s\\%s.mat',out_dir,eval(var_name_str))),
    eval(sprintf('save(''%s\\%s.mat'',%s,''-append'');',out_dir,eval(var_name_str),out_var_str));
else
    eval(sprintf('save(''%s\\%s.mat'',%s);',out_dir,eval(var_name_str),out_var_str));
end

