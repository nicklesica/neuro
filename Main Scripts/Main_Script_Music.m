startup_database

%%
%just_these_dates = {};

%% MU*A
clear pars

pars = [];

% pars.fs = 24414.0625;
% pars.rebin = 24;
% pars.t_min = 0;
% pars.t_max = 0.224;
% pars.t_min_counts = 0.008;
% pars.t_max_counts = 0.068;
%
% pars.p_type = 'PST';
% pars.r_name = 'R';
%
% pars.p_sig = 0.001;
% pars.f_step_octave = 0.5;
% pars.tun_interp = 10;
% pars.n_shuff = 25;
%
% pars.decode_cells = 10;
% pars.decode_knn = 16;
% pars.decode_pops = 100;
% pars.n_classes = 9;
% pars.n_trials = 64;

clear in

in.s1='mu*a';
in.loc1='*';
in.s2='*';
in.loc2='*';
in.snr='*';
in.level='*';
in.trial='1';
in.type={'CON','NEX','NE1','NE0','OLD'};
in.ha_flag = '01';

[date_list,sound_list] = Query_Database_All(in,database_dir,'skip');

sound_list_1 = sound_list;

[sound_list_1,sound_list_2] = Create_Paired_Sound_Lists(sound_list_1,'-_-_-_-_-_-_2');

if length(just_these_dates),
    date_list_1 = intersect(date_list,just_these_dates);
else
    date_list_1 = date_list;
end

date_list_2 = date_list_1;

for i_date_1 = 1:length(date_list_1),
    
    date_1 = date_list_1{i_date_1}
    date_2 = date_1;
    
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        sound_2 = sound_list_2{i_sound_1}
        
        One_Mean_Spike_Rate(sound_1,date_1);
        One_Coherence_Cross_Trial(sound_1,date_1,pars,sound_2,date_2);
    end
end

%% MU*B

clear in

in.s1='mu*b';
in.loc1='*';
in.s2='*';
in.loc2='*';
in.snr='*';
in.level='*';
in.trial='1';
in.type={'CON','NEX','NE1','NE0','OLD'};
in.ha_flag = '01';

[date_list,sound_list] = Query_Database_All(in,database_dir,'skip');

sound_list_1 = sound_list;

[sound_list_1,sound_list_2] = Create_Paired_Sound_Lists(sound_list_1,'-_-_-_-_-_-_2');

if length(just_these_dates),
    date_list_1 = intersect(date_list,just_these_dates);
else
    date_list_1 = date_list;
end

date_list_2 = date_list_1;

for i_date_1 = 1:length(date_list_1),
    
    date_1 = date_list_1{i_date_1}
    date_2 = date_1;
    
    for i_sound_1 = 1:length(sound_list_1),
        
        sound_1 = sound_list_1{i_sound_1}
        sound_2 = sound_list_2{i_sound_1}
        
        One_Mean_Spike_Rate(sound_1,date_1);
        One_Coherence_Cross_Trial(sound_1,date_1,pars,sound_2,date_2);
    end
end