% startup_database
% date_list_1 = database_dates_music_all;

Get_All_RLF_Sounds

sound_list_1 = sound_list;

%% Parameters
clear pars

pars.fs = 24414.0625/24;

pars.overwrite = 1;

pars.rearrange0.rebin = 1;

pars.rearrange.rebin = 1;

pars.tones.t_min = 0.008;
pars.tones.t_max = 0.068;

pars.tones.p_sig = 0.001;

%%
for i_date_1 = 1:length(date_list_1),
    
    date_1 = date_list_1{i_date_1}
    
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        One_Mean_Spike_Rate(sound_1,date_1,pars);
        
        [s1,~,~,~,~,level] = Parse_Database_Name(sound_1);
        
        ix_ha = findstr(level,'ha');
        
        if length(ix_ha),
            level = level(1:ix_ha-1);
        end
        
        switch Parse_Database_Name(sound_1)
            case 'rlf'
                pars.p_type = 'RLF';
                pars.rearrange0.stim_file = sprintf('RLF_2019_%s_25kHz.mat',level);
                
            case 'rlf2'
                pars.p_type = 'RLF2';
                pars.rearrange0.stim_file = 'RLF_2020_25kHz.mat';
        end
        
        One_Rearrange_By_Sounds_And_Repeats(sound_1,date_1,pars);
        One_Response_Rearrange(sound_1,date_1,pars);
        One_RLF_Analysis(sound_1,date_1,pars);
        
    end
end
