function One_Decode_By_Cell(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Decode_By_Cell';
out_vars = {'IXA','PC','SIG','STD0'};

%%
two_sound_flag = nargin>3;

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
        
        if length(IXA),
            
            %         r_1 = r_1(:,IXA);
            
            %                 if two_sound_flag,
            %                     r_2 = r_2(:,IXA);
            %                 end
            
            %% Do calculations - edit this
            
            switch pars.decode.type
                
                case 'KNN'
                    
                    dist = Get_Database_Analysis({date_1},sound_1,sprintf('%s_%s_%s',pars.decode.dist_name,pars.p_type,pars.r_name),'DIST');
                    
                    [~,~,n_taus,n_cells] = size(dist);
                    
                    Decode_By_Cell_Helper
                    
                case 'SVM'
                    
                    R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',sprintf('%s%s',pars.r_name,pars.p_type));
                    
                    [n_bins,n_classes,n_trials,n_cells] = size(R);
                    
                    n_taus = 1;
                    
                    Decode_By_Cell_Helper
                    
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



