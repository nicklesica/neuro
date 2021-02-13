function One_LowD_Temporal(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Rearranged_Responses';
out_vars = {'IXA',sprintf('TLD%d%s',pars.lowD.final_tdim,pars.p_type)};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

Make_Out_Var_String

mkdir(out_dir)

%%
% date_1

% sound_1

Check_For_Existing_Results

if (length(existing_results) ~= length(out_vars)) | pars.overwrite == 1,
    
    load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_1));
    
    if exist(sprintf('R_%s',sound_1)),
        
        sound_str = sound_1;
        if findstr(sound_1,'ha'),
            sound_str = [sound_str(1:end-4) sound_str(end-1:end)];
        end
        
        if exist(sprintf('%s\\Nick\\Other\\Database_Analysis\\LowD_Basis_From_All_%s_%s\\%s.mat',evalin('base','dropbox_dir'),pars.p_type,pars.r_name,sound_str)),
            
            fprintf('Writing\n');
            
            new_result = 0;
            
            One_Helper_Get_These_Responses
            
            One_Helper_Get_Valid_Indices
            
            if length(IXA),
                
                %         r_1 = r_1(:,IXA);
                
                %                 if two_sound_flag,
                %                     r_2 = r_2(:,IXA);
                %                 end
                
                %% Do calculations - edit this
                R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',strcat(pars.r_name,pars.p_type));
                %         R = Rebin_Response(R,pars.lowD.rebin);
                [n_bins,n_classes,n_trials,n_cells] = size(R);
                
                database_types = evalin('base','database_types');
                database_dates = evalin('base','database_dates');
                type = lower(database_types(database_dates==str2num(date_1)));
                type = type{1};
                
                if strcmp(type,'nex'),
                    if ~isempty(findstr(sound_1,'ha')),
                        type = 'ha';
                    end
                end
                
                load(sprintf('%s\\Nick\\Other\\Database_Analysis\\LowD_Basis_From_All_%s_%s\\%s.mat',evalin('base','dropbox_dir'),pars.p_type,pars.r_name,sound_str),...
                    strcat(type,'_TFEAT_1'))
                
                TFEAT = eval(strcat(type,'_TFEAT_1'));
                
                % Project onto basis
                temp = reshape(R,n_bins,[]);
                n_dim = min(pars.lowD.final_tdim,size(TFEAT,2));
                temp = TFEAT(:,1:n_dim)'*temp;
                temp = reshape(temp,n_dim,n_classes,n_trials,n_cells);
                
                %         temp = reshape(temp,[],n_cells)';
                %         temp = R_cell_smooth_features'*temp;
                %         temp = reshape(temp,size(temp,1),[],n_classes,n_trials);
                %         temp = reshape(temp,size(temp,1)*size(temp,2),size(temp,3),size(temp,4));
                %
                %         R_lowD = permute(temp,[2 3 1]);
                
                eval(sprintf('TLD%d%s = temp;',pars.lowD.final_tdim,pars.p_type));
                
                %%
                Helper_Rename_Results
                
                new_result = 1;
            end
            
            One_Helper_Save_Results
            
        else
            fprintf('Skipping because basis is not there\n');
        end
    else
        fprintf('Skipping because responses are not there\n');
    end
else
    fprintf('Skipping because results are already there\n');
end


