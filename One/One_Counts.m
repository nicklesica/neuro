function One_Counts(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Rearranged_Responses';
out_vars = {'IXA','C0'};

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
    
    if exist(sprintf('R_%s',sound_1)),
        
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
            
            R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses','R0');
            
            C0 = sum(R);
            
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


