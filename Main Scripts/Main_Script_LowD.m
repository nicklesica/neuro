% startup_database

%% Sounds

% Get_All_CV_Sounds

% sound_list_1 = sound_list;

sound_list_1 = {
    'c_c_x_x_x_62_1'
%     'c_c_n_o_0_62_1'
%     'c_c_x_x_x_83_1'
%     'c_c_n_o_0_83_1'
%     'c_c_x_x_x_62ha_1'
%     'c_c_n_o_0_62ha_1'
%     'c_c_x_x_x_83ha_1'
%     'c_c_n_o_0_83ha_1'
    };

%% Dates
date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
clear pars

pars.fs = 24414.0625;
pars.rearrange0.rebin = 24;

%%

if 1
    %% Create lowD temporal
    
    % Parameters
    pars.lowD.basis_tdim = 0;
    
    pars.vis3D.t_min = 0;
    pars.vis3D.t_max = 0.25;
    pars.vis3D.ix_classes = ix_full_12(my_sort_12_of_12);
    pars.vis3D.rebin = 5;
    
    pars.p_type = 'CV12';
    pars.r_name = 'R';
    
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        if isempty(findstr(sound_1,'ha')),
            
%             One_LowD_Temporal_Basis_From_All(sound_1,date_list_1,pars)
            
            One_Vis3D_From_All(sound_1,date_list_1,pars)
            
        end
    end
end


if 0
    %% Create lowD temporal
    
    % Parameters
    pars.p_type = 'CV12';
    pars.r_name = 'R';
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            pars.lowD.final_tdim = 3;
            One_LowD_Temporal(sound_1,date_1,pars);
            
            pars.lowD.final_tdim = 1;
            One_LowD_Temporal(sound_1,date_1,pars);
            
        end
    end
end



if 0
    %% Create lowD spatial -- in bau
    
    % Parameters
    pars.p_type = 'CV12';
    pars.r_name = 'C';
    
    %
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        if isempty(findstr(sound_1,'ha')),
            
            One_LowD_Spatial_Basis_From_All(sound_1,date_list_1,pars)
            
        end
    end
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1}
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1}
            
            One_LowD_Spatial(sound_1,date_1,pars);
            
        end
    end
end


if 0
    %% Analysis
    
    % Parameters
    pars.p_type = 'CV12';
    pars.r_names = {'TLD3'};%,'TLD3'};
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
                    One_Signal_And_Noise(sound_1,date_1,pars);
                    One_Dist(sound_1,date_1,pars);
                    
                end
            end
        end
    end
end

