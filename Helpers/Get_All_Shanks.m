save_dir = fullfile(dropbox_dir,'Nick\Other\Database_Analysis\Shanks');
mkdir(save_dir);

% Get shank for every cell
for i_exp = 1:length(database_dates),
    
    this_date = database_dates(i_exp)
    
    this_type = string(database_types(database_dates==this_date))
    
    if this_date > 190000,
        files = dir(fullfile(dropbox_dir,sprintf('Nick\\FinalData\\Consonants\\%d\\%d_Spikes.mat',this_date,this_date)))
    else
        files = dir(fullfile(dropbox_dir,sprintf('Nick\\FinalData\\Speech_HRTF_2018_New\\%d\\%d_Spikes.mat',this_date,this_date)))
    end
    
    if length(files),
        
        load(files(1).name);
        
        shank = getFromStruct(data,'shank')';
        
        SHANK_shank_1 = shank(:)';
        
        save(fullfile(save_dir,sprintf('%d.mat',this_date)),'SHANK_shank_1');
        
    end
end