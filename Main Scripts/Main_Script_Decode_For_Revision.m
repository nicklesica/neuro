% startup_database

%% Sounds

% Get_All_CV_Sounds
% sound_list_1 = sound_list;

% Get_All_VC_Sounds
% sound_list_1 = sound_list;

sound_list_1 = {
    'c_c_x_x_x_62_1'
%         'c_c_x_x_x_83_1'
    %     'c_c_x_x_x_62ha_1'
    %     'c_c_x_x_x_83ha_1'
%         'c_c_n_o_0_62_1'
%         'c_c_n_o_0_83_1'
    %     'c_c_n_o_0_62ha_1'
    %     'c_c_n_o_0_83ha_1'
%         'c_c_s1_c_0_62_1'
%         'c_c_s1_c_0_83_1'
    %     'c_c_s1_c_0_62ha_1'
    %     'c_c_s1_c_0_83ha_1'
    };

% sound_list_1 = {
%     'c_c_s1_c_0_62_1'
%     'c_c_s1_c_0_83_1'
%     'c_c_fm_o_z6_62_1'
%     'c_c_fm_o_z6_83_1'
%     'c_c_hp_o_z6_62_1'
%     'c_c_hp_o_z6_83_1'
%     'c_c_lp_o_z6_62_1'
%     'c_c_lp_o_z6_83_1'
%     'c_c_mm_o_z6_62_1'
%     'c_c_mm_o_z6_83_1'
%     'c_c_n_o_z6_56_1'
%     'c_c_n_o_z6_62_1'
%     'c_c_n_o_z6_69_1'
%     'c_c_n_o_z6_76_1'
%     'c_c_n_o_z6_83_1'
%     'c_c_s1_c_z6_62_1'
%     'c_c_s1_c_z6_83_1'
%     'v_c_x_x_x_62_1'
%     'v_c_x_x_x_83_1'
%     'v_c_n_o_z6_62_1'
%     'v_c_n_o_z6_83_1'
%     %
%     'c_c_s1_c_0_62ha_1'
%     'c_c_s1_c_0_83ha_1'
%     'c_c_fm_o_z6_62ha_1'
%     'c_c_fm_o_z6_83ha_1'
%     'c_c_hp_o_z6_62ha_1'
%     'c_c_hp_o_z6_83ha_1'
%     'c_c_lp_o_z6_62ha_1'
%     'c_c_lp_o_z6_83ha_1'
%     'c_c_mm_o_z6_62ha_1'
%     'c_c_mm_o_z6_83ha_1'
%     'c_c_n_o_z6_56ha_1'
%     'c_c_n_o_z6_62ha_1'
%     'c_c_n_o_z6_69ha_1'
%     'c_c_n_o_z6_76ha_1'
%     'c_c_n_o_z6_83ha_1'
%     'c_c_s1_c_z6_62ha_1'
%     'c_c_s1_c_z6_83ha_1'
%     'v_c_x_x_x_62ha_1'
%     'v_c_x_x_x_83ha_1'
%     'v_c_n_o_z6_62ha_1'
%     'v_c_n_o_z6_83ha_1'
%     };


% sound_list_1 = {
%     'c_c_x_x_x_62_1'
%     };

%% Dates
date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
clear pars

% pars.r_names = {'C','R','TLD1','TLD3'};
% pars.r_names = {'C','TLD1','TLD3'};
pars.r_names = {'R'};
pars.shuff_names = {''};

pars.p_type = 'CV12';
pars.n_classes = 12;
pars.n_trials = 32;

% pars.p_type = 'VC8';
% pars.n_classes = 8;
% pars.n_trials = 64;

pars.decode.knn = [16];
pars.decode.n_shuff = 32;
pars.decode.sig_stds = 3;

pars.decode.cells = [25 50 100 150];
pars.decode.pops = 10;

pars.overwrite = 1;

%%

if 1
    %% Populations -- cells w/ BF = 1 kHz and split by shank
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        if isempty(findstr(sound_1,'ha')),
            
            for i_resp = 1:length(pars.r_names),
                for i_shuff = 1:length(pars.shuff_names),
                    
                    pars.r_name = strcat(pars.r_names{i_resp},pars.shuff_names{i_shuff});
                    
                    pars.decode.type = 'SVM';
                    pars.decode.dist_name = 'RAW';
                    
%                     One_Decode_From_All_For_Revision_1(sound_1,date_list_1,pars);
                    One_Decode_From_All_For_Revision_2(sound_1,date_list_1,pars);
                    
                    %                     if strcmp(pars.r_names{i_resp},'R'),
                    %                         pars.decode.type = 'KNN';
                    %                         pars.decode.dist_name = 'Dist_Victor';
                    %
                    %                         One_Decode_Noverlap_From_All(sound_1,date_list_1,pars);
                    %                     end
                    
                end
            end
        end
    end
end


