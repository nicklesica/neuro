function One_Counts_Merge_Trials(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Rearranged_Responses';
out_vars = {'IXA',strcat('C',pars.p_type)};

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
            
            C = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',strcat('C',pars.p_type));
            
            for i_block = 2:pars.n_merge,
                
                temp = Get_Database_Analysis({date_1},strcat(sound_1(1:end-1),num2str(i_block)),'Rearranged_Responses',strcat('C',pars.p_type));
                
                C = cat(ndims(C)-1,C,temp);
                
            end
            
            eval(sprintf('%s = C;',strcat('C',pars.p_type)))
            
            for i_var = 1:length(out_vars),
                eval(sprintf('%s_%s%d = %s;',out_vars{i_var},eval(var_name_str),pars.n_merge,out_vars{i_var}));
            end
            
            new_result = 1;
        end
        
        One_Helper_Save_Results
        
    else
        fprintf('Skipping because responses are not there\n');
    end
else
    fprintf('Skipping because results are already there\n');
end




