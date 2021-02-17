function One_Signal_And_Noise(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = sprintf('Signal_And_Noise_%s_%s',pars.p_type,pars.r_name);
out_vars = {'IXA','SIG','NOISE'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);

mkdir(out_dir)

Make_Out_Var_String

%%
% date_1

% sound_1

Check_For_Existing_Results

if (length(existing_results) ~= length(out_vars)) | pars.overwrite == 1,
    
    load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_1));
    
    if exist(sprintf('R_%s',sound_1)),
        
        new_result = 0;
        
        One_Helper_Get_These_Responses
        
        One_Helper_Get_Valid_Indices
        
        %% Do calculations - edit this
        R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',sprintf('%s%s',pars.r_name,pars.p_type));
        
        [n_bins,n_classes,n_trials,n_cells] = size(R);
        
        if min(size(R)),
            
            fprintf('Writing\n');
            
            SIG = squeeze(mean(R,3));
            
            if ndims(SIG) == 2,
                
                SIG = permute(SIG,[3 1 2]);
                
            end
            
            NOISE = R - repmat(permute(SIG,[1 2 4 3]),1,1,n_trials,1);
            
            %%
            Helper_Rename_Results
            
            new_result = 1;
            
            One_Helper_Save_Results
        else
            fprintf('Skipping because modified responses are not there\n');
        end
    else
        fprintf('Skipping because original responses are not there\n');
    end
else
    fprintf('Skipping because results are already there\n');
end





