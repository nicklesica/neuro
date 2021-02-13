% startup_database

%% Sounds

% Get_All_Coherence_Sounds_CV

% Get_All_Coherence_Sounds_MF

% sound_list_1 = {
%     'c_c_x_x_x_62_1'
%     'c_c_x_x_x_83_1'
%     'm1tf_c_x_x_x_56_1'
%     'm1tf_c_x_x_x_66_1'
%     'm1tf_c_x_x_x_76_1'
%     'm1tf_c_x_x_x_83_1'
%     'f1tf_c_x_x_x_66_1'
%     'f1tf_c_x_x_x_76_1'
%     'f1tf_c_x_x_x_83_1'
%     };
%
% sound_list_2 = {
%     'c_c_x_x_x_62ha_1'
%     'c_c_x_x_x_83ha_1'
%     'm1tf_c_x_x_x_56ha_1'
%     'm1tf_c_x_x_x_66ha_1'
%     'm1tf_c_x_x_x_76ha_1'
%     'm1tf_c_x_x_x_83ha_1'
%     'f1tf_c_x_x_x_66ha_1'
%     'f1tf_c_x_x_x_76ha_1'
%     'f1tf_c_x_x_x_83ha_1'
%     };

% FOR CROSS TRIAL NUISANCE ETC.
% sound_list_1 = {
%     'c_c_x_x_x_62_1'
%     'c_c_x_x_x_83_1'
%     'c_c_x_x_x_62ha_1'
%     'c_c_x_x_x_83ha_1'
%     };
% 
% sound_list_2 = {
%     'c_c_x_x_x_62_1'
%     'c_c_x_x_x_83_1'
%     'c_c_x_x_x_62ha_1'
%     'c_c_x_x_x_83ha_1'
%     'c_c_n_o_0_62_1'
%     'c_c_n_o_0_83_1'
%     'c_c_n_o_0_62ha_1'
%     'c_c_n_o_0_83ha_1'
%     'c_c_s1_c_0_62_1'
%     'c_c_s1_c_0_83_1'
%     'c_c_s1_c_0_62ha_1'
%     'c_c_s1_c_0_83ha_1'
% %     'c_c_s1_c_z6_62_1'
% %     'c_c_s1_c_z6_83_1'
% %     'c_c_s1_c_z6_62ha_1'
% %     'c_c_s1_c_z6_83ha_1'
% %     'c_c_n_o_z6_62_1'
% %     'c_c_n_o_z6_83_1'
% %     'c_c_n_o_z6_62ha_1'
% %     'c_c_n_o_z6_83ha_1'
% };

% FOR SAME TRIAL NUISANCE ETC.
sound_list_1 = {
    'c_c_x_x_x_62_1'
    'c_c_x_x_x_83_1'
    'c_c_x_x_x_62ha_1'
    'c_c_x_x_x_83ha_1'
    'c_c_n_o_0_62_1'
    'c_c_n_o_0_83_1'
    'c_c_n_o_0_62ha_1'
    'c_c_n_o_0_83ha_1'
    'c_c_s1_c_0_62_1'
    'c_c_s1_c_0_83_1'
    'c_c_s1_c_0_62ha_1'
    'c_c_s1_c_0_83ha_1'
%     'c_c_s1_c_z6_62_1'
%     'c_c_s1_c_z6_83_1'
%     'c_c_s1_c_z6_62ha_1'
%     'c_c_s1_c_z6_83ha_1'
%     'c_c_n_o_z6_62_1'
%     'c_c_n_o_z6_83_1'
%     'c_c_n_o_z6_62ha_1'
%     'c_c_n_o_z6_83ha_1'
};

% % FOR TONES
% sound_list_1 = {
%     'pst_c_x_x_x_62_1'
%     'pst_c_x_x_x_62ha_1'
%     };

% % FOR TEST
sound_list_1 = {
    'c_c_x_x_x_62_1'
    'c_c_x_x_x_62ha_1'
    };

ha_flag = 0;

%% Dates
date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
clear pars

pars.fs = 24414.0625;
pars.rearrange0.rebin = 24;

pars.overwrite = 0;

%%
if 0
    %% Cross-trial coherence
    
    % Parameters
    pars.coh.rebin = 1;
    
    pars.coh.f_tot = [0.2 500];
    pars.coh.f_env = [0.2 60];
    pars.coh.f_pfs = [85 500];
    
    pars.coh.n_shuff = 20;
    pars.coh.n_0 = 0;
    
    pars.coh.dir = 'Coherence_Cross_Trial';
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        for i_sound_2 = 1:length(sound_list_2),
            
            sound_1 = sound_list_1{i_sound_1};
            sound_2 = sound_list_2{i_sound_2};
            
            if strcmp(sound_1,sound_2),
                
                sound_2(end) = '2';
                
            end
            
            [s1_1,loc1_1,s2_1,loc2_1,snr_1,level_1,trial_1] = Parse_Database_Name(sound_1);
            [s1_2,loc1_2,s2_2,loc2_2,snr_2,level_2,trial_2] = Parse_Database_Name(sound_2);
            
            if ha_flag,
                
                cond = strcmp(s1_1,s1_2) & strcmp(loc1_1,loc1_2) & strcmp(level_1(1:2),level_2(1:2))
                
            else
                
                cond = strcmp(s1_1,s1_2) & strcmp(loc1_1,loc1_2) & strcmp(level_1,level_2);
                
            end
            
            if cond,
                
                sound_1
                sound_2
                
                for i_date_1 = 1:length(date_list_1),
                    
                    date_1 = date_list_1{i_date_1}
                    
                    One_Coherence_Cross_Trial(sound_1,date_1,pars,sound_2,date_1)
                    One_Coherence_Total(sound_1,date_1,pars,sound_2,date_1)
                    
                end
            end
        end
    end
end


if 0
    %% Noise and nuisance coherence -- cross trial only
    
    % Parameters
    pars.p_type = 'CV12';
    
    pars.coh.rebin = 1;
    
    pars.coh.t_min = 0;
    pars.coh.t_max = 0.15;
    pars.coh.ix_classes = ix_full_12(my_sort_12_of_12);
    pars.coh.f_min = 1/(153*24/24414.0625);
    
    pars.coh.f_tot = [pars.coh.f_min 500];
    pars.coh.f_env = [pars.coh.f_min 60];
    pars.coh.f_pfs = [70 500];
    pars.coh.n_shuff = 20;
    pars.coh.n_0 = 20;
    pars.coh.n_shuff_trials = 20;
    pars.coh.sig_pct = 95;
    
    pars.coh.dir = 'Coherence_Noise_Nuisance';
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        for i_sound_2 = 1:length(sound_list_2),
            
            sound_1 = sound_list_1{i_sound_1};
            sound_2 = sound_list_2{i_sound_2};
            
            if strcmp(sound_1,sound_2),
                
                sound_2(end) = '2';
                
            end
            
            [s1_1,loc1_1,s2_1,loc2_1,snr_1,level_1,trial_1] = Parse_Database_Name(sound_1);
            [s1_2,loc1_2,s2_2,loc2_2,snr_2,level_2,trial_2] = Parse_Database_Name(sound_2);
            
            if ha_flag,
                
                cond = strcmp(s1_1,s1_2) & strcmp(loc1_1,loc1_2) & strcmp(level_1(1:2),level_2(1:2))
                
            else
                
                cond = strcmp(s1_1,s1_2) & strcmp(loc1_1,loc1_2) & strcmp(level_1,level_2);
                
            end
            
            if cond,
                
                sound_1
                sound_2
                
                for i_date_1 = 1:length(date_list_1),
                    
                    date_1 = date_list_1{i_date_1}
                    
                    One_Coherence_Noise_Nuisance(sound_1,date_1,pars,sound_2,date_1)
                    One_Coherence_Total(sound_1,date_1,pars,sound_2,date_1)
                    
                end
            end
        end
    end
end


if 1
    %% Noise and nuisance coherence -- same trial only
    
    % Parameters
    pars.coh.rebin = 1;
    
%     pars.p_type = 'PST9';
%     
%     pars.coh.t_min = 0.008;
%     pars.coh.t_max = 0.068;
%     pars.coh.ix_classes = 1:9;
%     pars.coh.f_min = 1/(62*24/24414.0625);
    
        pars.p_type = 'CV12';
    
        pars.coh.t_min = 0;
        pars.coh.t_max = 0.15;
        pars.coh.ix_classes = ix_full_12(my_sort_12_of_12);
        pars.coh.f_min = 1/(153*24/24414.0625);
    
    pars.coh.f_tot = [pars.coh.f_min 500];
    pars.coh.f_env = [pars.coh.f_min 60];
    pars.coh.f_pfs = [70 500];
    pars.coh.n_shuff = 20;
    pars.coh.n_shuff_trials = 20;
    pars.coh.sig_pct = 95;
    
    pars.coh.dir = 'Coherence_Noise_Nuisance';
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1};
        
        sound_1
        
        for i_date_1 = 1:length(date_list_1),
            
            date_1 = date_list_1{i_date_1}
            
            One_Coherence_Noise_Nuisance(sound_1,date_1,pars)
            One_Coherence_Total(sound_1,date_1,pars,sound_1,date_1)
            
        end
    end
end


if 0
    %% Noise and nuisance counts -- cross trial only
    
    % Parameters
    
    pars.p_type = 'CV12';
    pars.r_name = 'C';
    pars.coh.n_shuff = 100;
    pars.coh.sig_pct = 99;
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        for i_sound_2 = 1:length(sound_list_2),
            
            sound_1 = sound_list_1{i_sound_1};
            sound_2 = sound_list_2{i_sound_2};
            
            if strcmp(sound_1,sound_2),
                
                sound_2(end) = '2';
                
            end
            
            [s1_1,loc1_1,s2_1,loc2_1,snr_1,level_1,trial_1] = Parse_Database_Name(sound_1);
            [s1_2,loc1_2,s2_2,loc2_2,snr_2,level_2,trial_2] = Parse_Database_Name(sound_2);
            
            if ha_flag,
                
                cond = strcmp(s1_1,s1_2) & strcmp(loc1_1,loc1_2) & strcmp(level_1(1:2),level_2(1:2))
                
            else
                
                cond = strcmp(s1_1,s1_2) & strcmp(loc1_1,loc1_2) & strcmp(level_1,level_2);
                
            end
            
            if cond,
                
                sound_1
                sound_2
                
                for i_date_1 = 1:length(date_list_1),
                    
                    date_1 = date_list_1{i_date_1}
                    
                    One_Counts_Noise_Nuisance(sound_1,date_1,pars,sound_2,date_1)
                    
                end
            end
        end
    end
end


if 0
    %% Noise and nuisance counts -- same trial only
    
    % Parameters
    
    pars.p_type = 'CV12';
    pars.r_name = 'C';
    pars.coh.n_shuff = 100;
    pars.coh.sig_pct = 99;
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1};
        
        sound_1
        
        for i_date_1 = 1:length(date_list_1),
            
            date_1 = date_list_1{i_date_1}
            
            One_Counts_Noise_Nuisance(sound_1,date_1,pars)
            
        end
    end
end