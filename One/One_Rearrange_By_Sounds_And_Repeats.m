function One_Rearrange_By_Sounds_And_Repeats(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Rearranged_Responses';
out_vars = {'IXA','R0','C0'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);

Make_Out_Var_String

mkdir(out_dir)

%%
% date_1

% sound_1

Check_For_Existing_Results

if (length(existing_results) ~= length(out_vars)) | pars.overwrite == 1,
    
    load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_1));
    
    if exist(sprintf('R_%s',sound_1)) == 1,
        
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
            
            %             new_r = Rearrange_Responses_By_Sounds_And_Trials(r_1,Parse_Database_Name(sound_1));
            new_r = Reshape_Response_2021(r_1,pars.rearrange0.stim_file,pars.fs);
            
            if isfield(pars.rearrange0,'t_max'),
                new_r = new_r(1:floor(pars.rearrange0.t_max*pars.fs),:,:,:,:,:,:);
            end
            
            if isfield(pars.rearrange0,'t_min'),
                new_r = new_r(ceil(pars.rearrange0.t_min*pars.fs)+1:end,:,:,:,:,:,:);
            end
            
            R0 = Rebin_Response(new_r,pars.rearrange0.rebin);
            
            C0 = sum(R0,1);
            
            %%
            Helper_Rename_Results
            
            new_result = 1;
        end
        
        One_Helper_Save_Results
        
    else
        fprintf('Skipping because responses are not there\n');
    end
else
    fprintf('Skipping because results are already there\n');
end

