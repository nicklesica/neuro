function One_Decode_Noverlap_From_All_For_Revision_1(sound_1,date_list_1,pars)

%% Setup - edit this
out_dir_name = 'Decode_Noverlap_From_All_For_Revision_1';
out_vars = {'PC'};

%%
var_name_str = 'sound_1';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

out_dir = sprintf('%s_%s_%s_%s_%s',out_dir,pars.decode.type,pars.decode.dist_name,pars.p_type,pars.r_name);

mkdir(out_dir)

Make_Out_Var_String_CON_NEX_HA

Check_For_Existing_Results_From_All

if (length(existing_results) ~= length(out_vars)) | pars.overwrite == 1,
    
    %% Get DIST
    %     if strcmp(pars.decode.type,'KNN'),
    %
    %         just_these_dates = date_list_1;
    %         var_strs = {'DIST'};
    %         dir_strs = {sprintf('%s_%s_%s',pars.decode.dist_name,pars.p_type,pars.r_name)};
    %         end_strs = {'1'};
    %         temp_str = var_name_str;
    %         var_name_strs = {eval(var_name_str)};
    %
    %         dir_str = dir_strs{1};
    %         var_name_str = var_name_strs{1};
    %         var_str = var_strs{1};
    %         end_str = end_strs{1};
    %
    %         Get_Database_Analysis_CON_NEX_HA
    %         Keep_Only_Valid_CON_NEX_HA_Each
    %         var_name_str = temp_str;
    %
    %     else
    con_DIST_1 = 0;
    nex_DIST_1 = 0;
    ha_DIST_1 = 0;
    %     end
    
    if ~strcmp(pars.decode.type,'KNN') | (strcmp(pars.decode.type,'KNN') & size(con_DIST_1,4)>1),
        
        %% Get R
        
        just_these_dates = date_list_1;
        var_strs = {strcat(pars.r_name,pars.p_type)};
        dir_strs = {'Rearranged_Responses'};
        end_strs = {'1'};
        temp_str = var_name_str;
        var_name_strs = {eval(var_name_str)};
        
        dir_str = dir_strs{1};
        var_name_str = var_name_strs{1};
        var_str = var_strs{1};
        end_str = end_strs{1};
        
        Get_Database_Analysis_CON_NEX_HA
        
        %% Get CF
        var_name_str = 'fra_c_x_x_x_83_1';
        end_str = '1';
        dir_str = 'FRA_Analysis';
        var_str = 'CF';
        
        Get_Database_Analysis_CON_NEX_HA
        
        %% Get Shank
        var_name_str = 'shank_1';
        end_str = '1';
        dir_str = 'Shanks';
        var_str = 'SHANK';
        
        Get_Database_Analysis_CON_NEX_HA
        
        shank_rng = [1 2 3 4 13 14 15 16];
        
        ix = intersect(con_ix_RCV12_1,find(con_CF_1==3&ismember(con_SHANK_1,shank_rng)));
        
        con_RCV12_1 = con_RCV12_1(:,:,:,ix);
        
        ix = intersect(nex_ix_RCV12_1,find(nex_CF_1==3&ismember(nex_SHANK_1,shank_rng)));
        
        nex_RCV12_1 = nex_RCV12_1(:,:,:,ix);
        
        ix = intersect(ha_ix_RCV12_1,find(ha_CF_1==3&ismember(ha_SHANK_1,shank_rng)));
        
        ha_RCV12_1 = ha_RCV12_1(:,:,:,ix);
        
        
        var_str = var_strs{1};
        end_str = end_strs{1};
        var_name_str = temp_str;
        
        
        
        %%
        n_cells = [size(eval(sprintf('con_%s_1',var_str)),4) size(eval(sprintf('nex_%s_1',var_str)),4) size(eval(sprintf('ha_%s_1',var_str)),4)]
        
        if n_cells(1) > 1,
            
            %CON
            R = eval(sprintf('con_%s_1',var_str));
            
            dist = con_DIST_1;
            
            n_taus = size(dist,3);
            
            [n_bins,n_classes,n_trials,n_cells] = size(R);
            
            Decode_Noverlap_From_All_Helper
            
            % Helper_Rename_Results
            
            for i_var = 1:length(out_vars),
                eval(sprintf('con_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
            end
            
            %NEX
            R = eval(sprintf('nex_%s_1',var_str));
            
            dist = nex_DIST_1;
            
            n_taus = size(dist,3);
            
            [n_bins,n_classes,n_trials,n_cells] = size(R);
            
            Decode_Noverlap_From_All_Helper
            
            % Helper_Rename_Results
            
            for i_var = 1:length(out_vars),
                eval(sprintf('nex_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
            end
            
            %HA
            R = eval(sprintf('ha_%s_1',var_str));
            
            dist = ha_DIST_1;
            
            n_taus = size(dist,3);
            
            [n_bins,n_classes,n_trials,n_cells] = size(R);
            
            Decode_Noverlap_From_All_Helper
            
            % Helper_Rename_Results
            
            for i_var = 1:length(out_vars),
                eval(sprintf('ha_%s_1 = %s;',out_vars{i_var},out_vars{i_var}));
            end
            
            if exist(sprintf('%s\\%s.mat',out_dir,eval(var_name_str))),
                eval(sprintf('save(''%s\\%s.mat'',%s,''-append'');',out_dir,eval(var_name_str),out_var_str));
            else
                eval(sprintf('save(''%s\\%s.mat'',%s);',out_dir,eval(var_name_str),out_var_str));
            end
            
        else
            fprintf('Skipping because responses are not there\n');
        end
    else
        fprintf('Skipping because distances are not there\n');
    end
else
    fprintf('Skipping because results are already there\n');
end
