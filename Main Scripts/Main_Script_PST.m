% startup_database

Get_All_PST_Sounds

sound_list_1 = sound_list;

date_list_1 = database_dates_music;

%% Parameters
clear pars

pars.fs = 24414.0625/24;

pars.overwrite = 1;

pars.rearrange0.rebin = 1;

pars.rearrange.rebin = 1;

pars.tones.t_min = 0.008;

pars.tones.p_sig = 0.0001;

%%
for i_date_1 = 1:length(date_list_1),
    
    date_1 = date_list_1{i_date_1}
    
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        
        One_Mean_Spike_Rate(sound_1,date_1,pars);
        
        switch Parse_Database_Name(sound_1)
            case 'pst'
                pars.p_type = 'PST';
                pars.rearrange0.stim_file = 'PSTt_25kHz.mat';
                pars.tones.f_step_octave = 0.5;
                pars.tones.tun_interp = 10;
                pars.tones.t_max = 0.068;
                
            case 'pst2'
                pars.p_type = 'PST2';
                pars.rearrange0.stim_file = 'PST_2021_25kHz.mat';
                pars.tones.f_step_octave = 0.4;
                pars.tones.tun_interp = 5;
                pars.tones.t_max = 0.093;
        end
        
%         One_Rearrange_By_Sounds_And_Repeats(sound_1,date_1,pars);
%         One_Response_Rearrange(sound_1,date_1,pars);
        One_PST_Analysis(sound_1,date_1,pars);
        
    end
end
