% startup_database

%% Sounds

sound_list_1 = {
    'c_c_x_x_x_62_1'
    'v_c_x_x_x_62_1'
    };%

%% Dates
date_list_1 = database_dates_good;

% date_list_1 = {'190724'};

%% Parameters
clear pars

pars.r_names = {'C','R','TLD1','TLD3'};
pars.shuff_names = {''};

pars.p_type = 'CV12';
pars.n_classes = 12;
pars.n_trials = 32;

pars.decode.knn = [16];
pars.decode.n_shuff = 32;
pars.decode.sig_stds = 3;

pars.decode.cells = [25 50 100 150];
pars.decode.pops = 100;

pars.decode.subset_name = 'VOCODED';

pars.overwrite = 1;

% Get indices for cells with responses to all sounds

just_these_dates = date_list_1'
var_name_strs = sound_list_1;
var_strs = {'MEAN'};
end_strs = {'1','2'};
dir_strs = {'Mean_Spike_Rate'};

pars.read.sparse_to_full = 0;
pars.read.keep_only_successive = 0; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 0;
pars.read.keep_only_valid = 2; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA
pars.read.ua_flag = 0;

Get_Database_Analysis_Helper

pars.decode.con_ix = con_ix_MEAN_1;
pars.decode.nex_ix = nex_ix_MEAN_1;
pars.decode.ha_ix = ha_ix_MEAN_1;

% Get indices for populations

pars.decode.con_pop_ix = {};

n_cells = length(pars.decode.con_ix);

max_pops = floor(n_cells/min(pars.decode.cells));

for i_cells = 1:length(pars.decode.cells),
    
    temp = floor(n_cells/pars.decode.cells(i_cells));
    
    ix0 = randperm(n_cells);
    
    for i_pop = 1:temp,
        
        pars.decode.con_pop_ix{i_cells,i_pop} = ix0((i_pop-1)*pars.decode.cells(i_cells)+[1:pars.decode.cells(i_cells)]);
        
    end
end

pars.decode.nex_pop_ix = {};

n_cells = length(pars.decode.nex_ix);

max_pops = floor(n_cells/min(pars.decode.cells));

for i_cells = 1:length(pars.decode.cells),
    
    temp = floor(n_cells/pars.decode.cells(i_cells));
    
    ix0 = randperm(n_cells);
    
    for i_pop = 1:temp,
        
        pars.decode.nex_pop_ix{i_cells,i_pop} = ix0((i_pop-1)*pars.decode.cells(i_cells)+[1:pars.decode.cells(i_cells)]);
        
    end
end

pars.decode.ha_pop_ix = {};

n_cells = length(pars.decode.ha_ix);

max_pops = floor(n_cells/min(pars.decode.cells));

for i_cells = 1:length(pars.decode.cells),
    
    temp = floor(n_cells/pars.decode.cells(i_cells));
    
    ix0 = randperm(n_cells);
    
    for i_pop = 1:temp,
        
        pars.decode.ha_pop_ix{i_cells,i_pop} = ix0((i_pop-1)*pars.decode.cells(i_cells)+[1:pars.decode.cells(i_cells)]);
        
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
                    
                    if ~strcmp(pars.r_names{i_resp},'R'),
                        
                        pars.decode.type = 'KNN';
                        pars.decode.dist_name = 'Dist';
                        
                    end
                    
                    One_Decode_Noverlap_From_All_Subset(sound_1,date_list_1,pars);
                    
                    %                     if strcmp(pars.r_names{i_resp},'R'),
                    %                         pars.decode.type = 'KNN';
                    %                         pars.decode.dist_name = 'Dist_Victor';
                    %
                    %                         One_Decode_Noverlap_From_All(sound_1,date_list_1,pars);
                    %                     end
                    
                    pars.decode.type = 'SVM';
                    pars.decode.dist_name = 'RAW';
                    
                    One_Decode_Noverlap_From_All_Subset(sound_1,date_list_1,pars);
                    
                end
            end
        end
    end
end
