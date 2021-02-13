% startup_database

%% Sounds

sound_list_1 = {
    'c_c_x_x_x_62_1'
    'c_c_x_x_x_62ha_1'
    };

%% Dates
date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
clear pars

pars.p_type = 'CV12D';
pars.r_names = {'C','R'};
pars.shuff_names = {''};

pars.fs = 24414.0625;

pars.rearrange0.rebin = 24;
pars.rearrange0.t_min = 0;
pars.rearrange0.t_max = 0.25;

% For counts
pars.counts.t_min = 0;
pars.counts.t_max = 0.15;
pars.counts.ix_classes = [ix_full_12(my_sort_12_of_12) repmat(17,1,12)];

% For binned responses
pars.rearrange.t_min = 0;
pars.rearrange.t_max = 0.15;
pars.rearrange.ix_classes = [ix_full_12(my_sort_12_of_12) repmat(17,1,12)];
pars.rearrange.rebin = 5;

pars.n_classes = 2;
pars.n_trials = 32*12;

pars.decode.knn = [16];
pars.decode.n_shuff = 32;
pars.decode.sig_stds = 3;

pars.decode.cells = [1 5 10];
% pars.decode.pops = 100;

pars.overwrite = 1;


if 1
    %% Create counts
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1};
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1};
            
            fprintf('%s\n',date_1);
            fprintf('%s\n',sound_1);
            
            One_Counts_Rearrange(sound_1,date_1,pars);
            
        end
    end
end

if 1
    %% Create binned responses
    
    for i_date_1 = 1:length(date_list_1),
        
        date_1 = date_list_1{i_date_1};
        
        for i_sound_1 = 1:length(sound_list_1),
            
            sound_1 = sound_list_1{i_sound_1};
            
            fprintf('%s\n',date_1);
            fprintf('%s\n',sound_1);
            
            One_Response_Rearrange(sound_1,date_1,pars);
            
        end
    end
end


if 0
    %% Cell-by-cell
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        if isempty(findstr(sound_1,'ha')),
            
            for i_resp = 1:length(pars.r_names),
                for i_shuff = 1:length(pars.shuff_names),
                    
                    pars.r_name = strcat(pars.r_names{i_resp},pars.shuff_names{i_shuff});
                    
                    for i_date_1 = 1:length(date_list_1),
                        
                        date_1 = date_list_1{i_date_1}
                        
                        pars.decode.type = 'KNN';
                        pars.decode.dist_name = 'Dist';
                        
                        One_Decode_By_Cell(sound_1,date_1,pars);
                        
                        if strcmp(pars.r_names{i_resp},'R'),
                            pars.decode.type = 'KNN';
                            pars.decode.dist_name = 'Dist_Victor';
                            
                            One_Decode_By_Cell(sound_1,date_1,pars);
                        end
                        
                        pars.decode.type = 'SVM';
                        pars.decode.dist_name = 'RAW';
                        
                        One_Decode_By_Cell(sound_1,date_1,pars);
                        
                    end
                end
            end
        end
    end
end


if 0
    %% By experiment
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        if isempty(findstr(sound_1,'ha')),
            
            for i_resp = 1:length(pars.r_names),
                for i_shuff = 1:length(pars.shuff_names),
                    
                    pars.r_name = strcat(pars.r_names{i_resp},pars.shuff_names{i_shuff});
                    
                    for i_date_1 = 1:length(date_list_1),
                        
                        date_1 = date_list_1{i_date_1}
                        
                        pars.decode.type = 'KNN';
                        pars.decode.dist_name = 'Dist';
                        
                        One_Decode_By_Experiment(sound_1,date_1,pars);
                        
                        if strcmp(pars.r_names{i_resp},'R'),
                            pars.decode.type = 'KNN';
                            pars.decode.dist_name = 'Dist_Victor';
                            
                            One_Decode_By_Experiment(sound_1,date_1,pars);
                        end
                        
                        pars.decode.type = 'SVM';
                        pars.decode.dist_name = 'RAW';
                        
                        One_Decode_By_Experiment(sound_1,date_1,pars);
                        
                    end
                end
            end
        end
    end
end

if 1
    %% Populations
    
    % Run
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        if isempty(findstr(sound_1,'ha')),
            
            for i_resp = 1:length(pars.r_names),
                for i_shuff = 1:length(pars.shuff_names),
                    
                    pars.r_name = strcat(pars.r_names{i_resp},pars.shuff_names{i_shuff});
                    
                    %                     if ~strcmp(pars.r_names{i_resp},'R'),
                    %
                    %                         pars.decode.type = 'KNN';
                    %                         pars.decode.dist_name = 'Dist';
                    %
                    %                     end
                    %
                    %                     One_Decode_Noverlap_From_All(sound_1,date_list_1,pars);
                    
                    %                     if strcmp(pars.r_names{i_resp},'R'),
                    %                         pars.decode.type = 'KNN';
                    %                         pars.decode.dist_name = 'Dist_Victor';
                    %
                    %                         One_Decode_Noverlap_From_All(sound_1,date_list_1,pars);
                    %                     end
                    
                    pars.decode.type = 'SVM';
                    pars.decode.dist_name = 'RAW';
                    
                    One_Decode_Noverlap_From_All(sound_1,date_list_1,pars);
                    
                end
            end
        end
    end
end
