clear all

%% Database information
dropbox_dir = 'C:\Users\lesica\Dropbox';

addpath(genpath(strcat(dropbox_dir,'\MFiles\MFiles Lab\Current\Database_Analysis - 1.0')))

database_dir = strcat(dropbox_dir,'\Nick\Other\IC_Database\Test');

database_analysis_dir = strcat(dropbox_dir,'\Nick\Other\Database_Analysis_Demo');
mkdir(database_analysis_dir);

database_dates = [100000 100001];
database_n_cells = [211 175];

%% Sounds and dates
sound_list_1 = {
    'c_c_x_x_x_62_1'
    };

date_list_1 = {
    '100000'
    '100001'
    };


%% Parameters
clear pars

pars.fs = 24414.0625/24;

pars.rearrange0.rebin = 1;
pars.rearrange0.t_min = 0;
pars.rearrange0.t_max = 0.25;
pars.rearrange0.stim_file = '16C_4V_8T_200ms_Gap_25kHz.mat';

pars.rearrange.t_min = 0;
pars.rearrange.t_max = 0.15;
pars.rearrange.ix_classes = [10 9 16 15 1 2 11 5 8 7 12 3];
pars.rearrange.rebin = 5;

pars.r_names = {'R'};
pars.shuff_names = {''};

pars.p_type = 'CV12';
pars.n_classes = 12;
pars.n_trials = 32;

pars.decode.knn = [16];
pars.decode.n_shuff = 32;
pars.decode.sig_stds = 3;

pars.decode.cells = [50];
pars.decode.pops = 10;

pars.overwrite = 1;

%% Rearrange responses and decode by experiment
for i_sound_1 = 1:length(sound_list_1),
    
    sound_1 = sound_list_1{i_sound_1}
    
    for i_resp = 1:length(pars.r_names),
        for i_shuff = 1:length(pars.shuff_names),
            
            pars.r_name = strcat(pars.r_names{i_resp},pars.shuff_names{i_shuff});
            
            for i_date_1 = 1:length(date_list_1),
                
                date_1 = date_list_1{i_date_1}
                
                One_Rearrange_By_Sounds_And_Repeats(sound_1,date_1,pars);
                
                One_Response_Rearrange(sound_1,date_1,pars);
                
                pars.decode.type = 'SVM';
                pars.decode.dist_name = 'RAW';
                
                One_Decode_By_Experiment(sound_1,date_1,pars);
                
            end
        end
    end
end

%% Plot the confusion matrices for each experiment
figure

subplot(1,2,1)
load(fullfile(database_analysis_dir,'Decode_By_Experiment_SVM_RAW_CV12_R\100000.mat'), 'CM_c_c_x_x_x_62_1')
imagesc(CM_c_c_x_x_x_62_1)

subplot(1,2,2)
load(fullfile(database_analysis_dir,'Decode_By_Experiment_SVM_RAW_CV12_R\100001.mat'), 'CM_c_c_x_x_x_62_1')
imagesc(CM_c_c_x_x_x_62_1)