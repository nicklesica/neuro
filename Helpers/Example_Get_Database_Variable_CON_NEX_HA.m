
%% Effect of HA on coherence

just_these_dates = database_dates_good;

% p_type = 'CV12';
% r_name = 'R';
% shuff_name = '';

% var_name_strs = {'c_c_x_x_x_62_1_c_c_x_x_x_62_2','c_c_x_x_x_62_1_c_c_x_x_x_62_2'};
var_name_strs = {'c_c_x_x_x_62_1_c_c_n_o_0_62_1','c_c_x_x_x_62_1_c_c_n_o_0_62_1'};
var_strs = {'COHENV','COHSENV'};
end_strs = {'1','1'};
dir_strs = {'Coherence_Noise_Nuisance'};

pars.read.sparse_to_full = 0;
pars.read.keep_only_successive = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 15;
pars.read.keep_only_valid = 3; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA

pars.hist.log_flag = 1;

Get_Database_Analysis_Helper
Plot_Database_Analysis_Helper

con_TOT_1 = con_TOT_1 - con_TOT_2;
nex_TOT_1 = nex_TOT_1 - nex_TOT_2;
ha_TOT_1 = ha_TOT_1 - ha_TOT_2;

var_strs = {'TOT'};
end_strs = {'1'};

pars.hist.log_flag = 0;

Plot_Database_Analysis_Helper

%%

% PST single cells
just_these_dates = database_dates_good;

p_type = 'PST9';
r_name = 'C';
dist_name = 'Dist';
% shuff_name = '';

var_name_strs = {'pst_c_x_x_x_62_1'};
var_strs = {'WID'};%'PC','WID'};
end_strs = {'1'};%,'1'};
dir_strs = {'PST_Analysis'};%sprintf('Decode_By_Cell_%s_%s_%s',dist_name,p_type,r_name)
pars.read.sparse_to_full = 0;
pars.read.keep_only_successive = 0; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 0;
pars.read.keep_only_valid = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA

pars.hist.log_flag = 0;

Get_Database_Analysis_Helper
Plot_Database_Analysis_Helper

% con_MEAN_1 = [];
% ha_MEAN_1 = ha_MEAN_1 - nex_MEAN_1;
% nex_MEAN_1 = nex_MEAN_2 - nex_MEAN_1;
% 
% var_strs = {'MEAN'};
% end_strs = {'1'};
% 
% pars.hist.log_flag = 0;
% 
% Plot_Database_Analysis_Helper

%% PC single cells

just_these_dates = database_dates_good;

p_type = 'CV12';
r_name = 'R';
dist_name = 'Dist_Victor';
% shuff_name = '';

var_name_strs = {'c_c_x_x_x_62_1','c_c_n_o_0_62_1'};
var_strs = {'PC'};
end_strs = {'1','2'};
dir_strs = {sprintf('Decode_By_Cell_%s_%s_%s',dist_name,p_type,r_name)};

pars.read.sparse_to_full = 0;
pars.read.keep_only_successive = 0; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 0;
pars.read.keep_only_valid = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA

pars.hist.log_flag = 0;

Get_Database_Analysis_Helper
Plot_Database_Analysis_Helper

% con_MEAN_1 = [];
% ha_MEAN_1 = ha_MEAN_1 - nex_MEAN_1;
% nex_MEAN_1 = nex_MEAN_2 - nex_MEAN_1;
% 
% var_strs = {'MEAN'};
% end_strs = {'1'};
% 
% pars.hist.log_flag = 0;
% 
% Plot_Database_Analysis_Helper


%% PC Noverlap_From_All

just_these_dates = database_dates_good;

p_type = 'CV12';
r_name = 'R';
dist_name = 'Dist_Victor';
% r_name = 'C';
% dist_name = 'Dist';
shuff_name = '';
ix_str = ':,:,end,end'; % tau,pops,knn,cells

var_name_strs = {'c_c_x_x_x_62_1','c_c_n_o_0_62_1'};
var_strs = {'PC'};
end_strs = {'1','2'};
dir_strs = {sprintf('Decode_Noverlap_From_All_%s_%s_%s',dist_name,p_type,r_name)};

pars.read.sparse_to_full = 0;
% pars.read.keep_only_successive = 0; %0 = ignore, 1 = var-by-var, 2 = across all vars
% pars.read.successive_max_diff = 0;
% pars.read.keep_only_valid = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA

pars.hist.log_flag = 0;

Get_Database_Analysis_From_All_CON_NEX_HA
Plot_Database_Analysis_Helper

%% Effect of HA on mean rate

just_these_dates = database_dates_good;

% p_type = 'CV12';
% r_name = 'R';
% shuff_name = '';

var_name_strs = {'c_c_x_x_x_62_1','c_c_x_x_x_62_2'};
var_strs = {'MEAN'};
end_strs = {'1','2'};
dir_strs = {'Mean_Spike_Rate'};

pars.read.sparse_to_full = 1;
pars.read.keep_only_successive = 2; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 2;
pars.read.keep_only_valid = 3; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA

pars.hist.log_flag = 1;

Get_Database_Analysis_Helper
Plot_Database_Analysis_Helper

con_MEAN_1 = [];
ha_MEAN_1 = ha_MEAN_1 - nex_MEAN_1;
nex_MEAN_1 = nex_MEAN_2 - nex_MEAN_1;

var_strs = {'MEAN'};
end_strs = {'1'};

pars.hist.log_flag = 0;

Plot_Database_Analysis_Helper

%% Effect of HA on SNR (nuisance vs noise)

just_these_dates = database_dates_good;

% p_type = 'CV12';
% r_name = 'R';
% shuff_name = '';

var_name_strs = {'c_c_x_x_x_62_1','cr_c_x_x_x_62_2'};
var_strs = {'VARN'};
end_strs = {'1','2'};
dir_strs = {'SNR_And_Corr_CV12_C','SNR_And_Corr_CVR12_C'};

pars.read.sparse_to_full = 1;
pars.read.keep_only_successive = 0; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 2;
pars.read.keep_only_valid = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA
pars.read.ua_flag = 1;

pars.hist.log_flag = 1;

Get_Database_Analysis_Helper
Plot_Database_Analysis_Helper

con_VARN_1 = [];
ha_VARN_1 = ha_VARN_1 - nex_VARN_1;
ua_VARN_1 = ua_VARN_1 - nex_VARN_1;
nex_VARN_1 = [];

var_strs = {'VARN'};
end_strs = {'1'};

pars.hist.log_flag = 0;

Plot_Database_Analysis_Helper

%% Effect of HA on coherence

just_these_dates = database_dates_good;

% p_type = 'CV12';
% r_name = 'R';
% shuff_name = '';

var_name_strs = {'c_c_x_x_x_62_1_c_c_x_x_x_62_2','m1tf_c_x_x_x_66_1_m1tf_c_x_x_x_66_2'};
var_strs = {'TOT'};
end_strs = {'1','2'};
dir_strs = {'Coherence_Total'};

pars.read.sparse_to_full = 0;
pars.read.keep_only_successive = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 15;
pars.read.keep_only_valid = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA

pars.hist.log_flag = 1;

Get_Database_Analysis_Helper
Plot_Database_Analysis_Helper

con_TOT_1 = con_TOT_1 - con_TOT_2;
nex_TOT_1 = nex_TOT_1 - nex_TOT_2;
ha_TOT_1 = ha_TOT_1 - ha_TOT_2;

var_strs = {'TOT'};
end_strs = {'1'};

pars.hist.log_flag = 0;

Plot_Database_Analysis_Helper

%% Coherence

just_these_dates = database_dates_good;

% p_type = 'CV12';
% r_name = 'R';
% shuff_name = '';

var_name_strs = {'c_c_x_x_x_62_1_c_c_x_x_x_62_2','m1tf_c_x_x_x_66_1_m1tf_c_x_x_x_66_2'};
var_strs = {'COH'};
end_strs = {'1','2'};
dir_strs = {'Coherence_Cross_T'};

pars.read.sparse_to_full = 0;
pars.read.keep_only_successive = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 15;
pars.read.keep_only_valid = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA

pars.hist.log_flag = 1;

Get_Database_Analysis_Helper
Plot_Database_Analysis_Helper

con_TOT_1 = con_TOT_1 - con_TOT_2;
nex_TOT_1 = nex_TOT_1 - nex_TOT_2;
ha_TOT_1 = ha_TOT_1 - ha_TOT_2;

var_strs = {'TOT'};
end_strs = {'1'};

pars.hist.log_flag = 0;

Plot_Database_Analysis_Helper

