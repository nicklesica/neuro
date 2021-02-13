%% Sounds

% Get_All_CV_Sounds

% sound_list_1 = sound_list;

% sound_list_1 = {
%     'c_c_x_x_x_62_1'
%     'c_c_n_o_0_62_1'
%     'c_c_x_x_x_83_1'
%     'c_c_n_o_0_83_1'
%     'c_c_x_x_x_62ha_1'
%     'c_c_n_o_0_62ha_1'
%     'c_c_x_x_x_83ha_1'
%     'c_c_n_o_0_83ha_1'
%     };

sound_list_1 = {
    'c_c_x_x_x_76_1'
    };

% sound_list_1 = {
%     'cr_c_x_x_x_62_2'
%     'cr_c_x_x_x_83_2'
%     'cr_c_x_x_x_62ha_2'
%     'cr_c_x_x_x_83ha_2'
%     };

%% Dates
date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
clear pars

%%

if 1
    %% Analysis
    
    % Parameters
%     pars.p_type = 'CVR12';
    pars.p_type = 'CV12';
    pars.r_names = {'C'};
    pars.shuff_names = {''};
    
    pars.n_classes = 12;
    pars.n_trials = 32;
    
    pars.dist.rebin = 1;
    
    % Run
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            for i_resp = 1:length(pars.r_names),
                for i_shuff = 1:length(pars.shuff_names),
                    
                    pars.r_name = strcat(pars.r_names{i_resp},pars.shuff_names{i_shuff});
                    
                    One_SNR_And_Corr(sound_1,date_1,pars);
%                     One_Signal_And_Noise(sound_1,date_1,pars);
%                     One_Dist(sound_1,date_1,pars);
                    
                end
            end
        end
    end
end
