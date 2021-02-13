% startup_database

%% Sounds

% Get_All_CV_Sounds

% sound_list_1 = sound_list;

sound_list_1 = {
    'c_c_x_x_x_62_1'
    'c_c_n_o_0_62_1'
    'c_c_x_x_x_83_1'
    'c_c_n_o_0_83_1'
    'c_c_x_x_x_62ha_1'
    'c_c_n_o_0_62ha_1'
    'c_c_x_x_x_83ha_1'
    'c_c_n_o_0_83ha_1'
    };

%% Dates
date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
clear pars

pars.fs = 24414.0625;

pars.rearrange0.rebin = 24;
pars.rearrange0.t_min = 0;
pars.rearrange0.t_max = 0.25;

if 1
    %% Victor distance
    
    % Parameters
    pars.p_type = 'CV12';
    pars.r_names = {'R'};
    
    pars.rearrange.t_min = 0;
    pars.rearrange.t_max = 0.15;
    pars.rearrange.ix_classes = ix_full_12(my_sort_12_of_12);
    
    %     pars.dist.taus = 0.001*2.^[0:8];
    
    pars.dist.taus = [0.01 0.025 0.05 0.1 10];
    
    % Run
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            for i_resp = 1:length(pars.r_names),
                
                pars.r_name = pars.r_names{i_resp};
                
                One_Dist_Victor(sound_1,date_1,pars);
                
            end
        end
    end
end
