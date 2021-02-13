function One_Decode_By_Experiment(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Decode_By_Experiment';
out_vars = {'PC','CM','F1'};

%%
two_sound_flag = nargin > 3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);

out_dir = sprintf('%s_%s_%s_%s_%s',out_dir,pars.decode.type,pars.decode.dist_name,pars.p_type,pars.r_name);

mkdir(out_dir)

Make_Out_Var_String


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
        
        if length(IXA) >= min(pars.decode.cells),
            
            %         r_1 = r_1(:,IXA);
            
            %                 if two_sound_flag,
            %                     r_2 = r_2(:,IXA);
            %                 end
            
            %% Do calculations - edit this
            
            n_cells = length(IXA);
            
            switch pars.decode.type
                
                case 'KNN'
                    
                    dist = Get_Database_Analysis({date_1},sound_1,sprintf('%s_%s_%s',pars.decode.dist_name,pars.p_type,pars.r_name),'DIST');
                    
                    n_taus = size(dist,3);
                    
                    Decode_By_Experiment_Helper
                    
                case 'SVM'
                    
                    R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',sprintf('%s%s',pars.r_name,pars.p_type));
                    
                    [n_bins,n_classes,n_trials,~] = size(R);
                    
                    n_taus = 1;
                    
                    Decode_By_Experiment_Helper
                    
            end
            
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





