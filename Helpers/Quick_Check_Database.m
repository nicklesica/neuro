clear in

in.s1='c';
in.loc1='c';
in.s2='n';
in.loc2='o';
in.snr='z6';
in.level='83';
in.trial='1';
in.type={'CON','NEX'};
in.ha_flag = '*';

Query_Database_All(in,database_dir);

edit(fullfile(database_dir,'report.txt'))
