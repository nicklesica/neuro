% startup_database

%% Sounds

sound_list_1 = {
    'mr_c_x_x_x_55_1'
    'mr_c_x_x_x_55_2'
    'mr_c_x_x_x_65_1'
    'mr_c_x_x_x_65_2'
    'mr_c_x_x_x_75_1'
    'mr_c_x_x_x_75_2'
    'mr_c_x_x_x_85_1'
    'mr_c_x_x_x_85_2'
    };

%% Dates
% date_list_1 = database_dates_all;

date_list_1 = {'210111'};

%% Parameters
clear pars

pars.fs = 24414.0625/24;

pars.rearrange0.rebin = 1;
pars.rearrange0.t_min = 0;
pars.rearrange0.t_max = 0.2;
pars.rearrange0.stim_file = fullfile(evalin('base','dropbox_dir'),'Nick\FinalData\Sounds','MR_2021_25kHz.mat');

pars.overwrite = 1;

%%
if 1
    %% Rearrange
    
    % Parameters
    
    % Run
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            One_Mean_Spike_Rate(sound_1,date_1,pars);
            One_Rearrange_By_Sounds_And_Repeats(sound_1,date_1,pars);
            One_Counts(sound_1,date_1,pars);
            
        end
    end
end


%% Sounds

sound_list_1 = {
    'mr_c_x_x_x_55_1'
    'mr_c_x_x_x_65_1'
    'mr_c_x_x_x_75_1'
    'mr_c_x_x_x_85_1'
    };

%%
if 1
    %% Merge trials
    
    % Parameters
        pars.p_type = '0';
        pars.n_merge = 2;
        
    % Run
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            One_Response_Merge_Trials(sound_1,date_1,pars);
            One_Counts_Merge_Trials(sound_1,date_1,pars);
            
        end
    end
end

if 1
    %% Split MR responses by MD
    
    % Parameters
    pars.p_type = 'MR16';
    
    pars.counts.t_min = 0.009;
    pars.counts.t_max = 0.115;
    pars.counts.ix_classes = 1:16;
    
    pars.rearrange.t_min = 0.009;
    pars.rearrange.t_max = 0.115;
    pars.rearrange.ix_classes = 1:16;
    
    pars.rearrange.rebin = 1;
    
    % Run
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            One_Response_Rearrange(sound_1,date_1,pars);
            One_Counts_Rearrange(sound_1,date_1,pars);
            
        end
    end
end


if 1
    %% Decode
    
    pars.p_type = 'MR1635';
    pars.r_name = 'R';
    
    pars.n_classes = 16;
    pars.n_trials = 16;
    
    pars.decode.dist_name = 'Dist';
    pars.decode.knn = [8];
    pars.decode.n_shuff = 5;
    pars.decode.sig_stds = 3;
    
    pars.decode.cells = [10 25];
    pars.decode.pops = 10;
    
    %
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            One_Signal_And_Noise(sound_1,date_1,pars);
            One_SNR_And_Corr(sound_1,date_1,pars);
            
            One_Dist(sound_1,date_1,pars);
            
            pars.decode.type = 'KNN';
            pars.decode.dist_name = 'Dist';
            
            One_Decode_By_Cell(sound_1,date_1,pars);
            One_Decode_By_Experiment(sound_1,date_1,pars);
            
            pars.decode.type = 'SVM';
            pars.decode.dist_name = 'RAW';
            
            One_Decode_By_Cell(sound_1,date_1,pars);
            One_Decode_By_Experiment(sound_1,date_1,pars);
            
        end
    end
end


% if 1
%     %% Decode PST pops
%     sound_list_1 = {
%         'pst_c_x_x_x_62_1'
%         'pst_c_x_x_x_83_1'
%         };
%     
%     % Parameters
%     pars.p_type = 'PST9';
%     %     pars.r_names = {'C'};
%     pars.r_names = {'R'};
%     pars.shuff_names = {''};
%     
%     pars.n_classes = 9;
%     pars.n_trials = 64;
%     
%     pars.decode.cells = [10 25];
%     pars.decode.knn = [16];
%     
%     %
%     for i_sound_1 = 1:length(sound_list_1),
%         
%         sound_1 = sound_list_1{i_sound_1}
%         
%         if isempty(findstr(sound_1,'ha')),
%             
%             for i_resp = 1:length(pars.r_names),
%                 for i_shuff = 1:length(pars.shuff_names),
%                     
%                     pars.r_name = strcat(pars.r_names{i_resp},pars.shuff_names{i_shuff});
%                     
%                     %                     pars.decode.type = 'KNN';
%                     %                     pars.decode.dist_name = 'Dist';
%                     %
%                     %                     One_Decode_Noverlap_From_All(sound_1,date_list_1,pars);
%                     
%                     pars.decode.type = 'SVM';
%                     pars.decode.dist_name = 'RAW';
%                     
%                     One_Decode_Noverlap_From_All(sound_1,date_list_1,pars);
%                     
%                 end
%             end
%         end
%     end
% end
% 
% 
% 
% if 0
%     %% Analyze FRA
%     sound_list_1 = {
%         'fra_c_x_x_x_83_1'
%         'fra_c_x_x_x_83ha_1'
%         };
%     
%     % Parameters
%     pars.tones.p_sig = 0.001;
%     pars.tones.f_step_octave = 0.5;
%     pars.tones.tun_interp = 10;
%     
%     pars.counts.t_min = 0.008;
%     pars.counts.t_max = 0.068;
%     pars.counts.ix_classes = 1:9;
%     
%     pars.tones.p_sig = 0.001;
%     
%     %
%     for i_date_1 = 1:length(date_list_1),
%         
%         date_1 = date_list_1{i_date_1}
%         
%         for i_sound_1 = 1:length(sound_list_1),
%             
%             sound_1 = sound_list_1{i_sound_1}
%             
%             One_FRA_Analysis(sound_1,date_1,pars);
%         end
%     end
% end

