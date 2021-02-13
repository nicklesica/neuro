% startup_database

%% Sounds

% Get_All_CV_Sounds
% Get_All_VC_Sounds

% sound_list_1 = sound_list;

% sound_list_1 = {
%     'cr_c_x_x_x_62_2'
%     'cr_c_x_x_x_83_2'
%     'cr_c_x_x_x_62ha_2'
%     'cr_c_x_x_x_83ha_2'
%     };

sound_list_1 = {
    'c_c_x_x_x_62_1'
};

%% Dates
date_list_1 = database_dates_all;
% date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
% clear pars
% 
% pars.fs = 24414.0625;
% 
% pars.rearrange0.rebin = 24;
% pars.rearrange0.t_min = 0;
% pars.rearrange0.t_max = 0.25;
% 
% % For counts
% pars.counts.t_min = 0;
% pars.counts.t_max = 0.15;
% % pars.counts.ix_classes = ix_full_12(my_sort_12_of_12);
% pars.counts.ix_classes = 1:8;
% 
% % For binned responses
% pars.rearrange.t_min = 0;
% pars.rearrange.t_max = 0.15;
% % pars.rearrange.ix_classes = ix_full_12(my_sort_12_of_12);
% pars.rearrange.ix_classes = 1:8;
% pars.rearrange.rebin = 5;
% 
pars.overwrite = 1;
% 
% % pars.p_type = 'CV12';
% % pars.p_type = 'VC8';
% % pars.p_type = 'CVR12';

%%
if 1
    %% 
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1};
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1};
            
            fprintf('%s\n',date_1);
            fprintf('%s\n',sound_1);
            
            One_Noise_Correlation_Cross_Trial(sound_1,date_1,pars,strcat(sound_1(1:end-1),'2'),date_1);
          
        end
    end
end
