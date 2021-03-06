function One_Counts_Shuffle(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Rearranged_Responses';
out_vars = {'IXA',sprintf('%sS%s',pars.r_name,pars.p_type),sprintf('%sN%s',pars.r_name,pars.p_type),sprintf('%sSN%s',pars.r_name,pars.p_type)};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

Make_Out_Var_String

mkdir(out_dir)

%%
% date_1

% sound_1

load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_1));

if exist(sprintf('R_%s',sound_1)),
    
    new_result = 0;
    
    One_Helper_Get_These_Responses
    
    One_Helper_Get_Valid_Indices
    
    if length(IXA),
        
        %         r_1 = r_1(:,IXA);
        
        %                 if two_sound_flag,
        %                     r_2 = r_2(:,IXA);
        %                 end
        
        %% Do calculations - edit this
       
        if length(IXA),

            R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',strcat(pars.r_name,pars.p_type));
            
            [n_bins,n_classes,n_trials,n_cells] = size(R);
            
            eval(sprintf('%sS%s = R;',pars.r_name,pars.p_type));
            eval(sprintf('%sN%s = R;',pars.r_name,pars.p_type));
            eval(sprintf('%sSN%s = R;',pars.r_name,pars.p_type));
            
            for i_cell = 1:n_cells,
                
                eval(sprintf('%sS%s(:,:,:,i_cell) = R(:,randperm(n_classes),:,i_cell);',pars.r_name,pars.p_type));
                
                for i_class = 1:n_classes-1,
                    
                    eval(sprintf('%sN%s(:,i_class,:,i_cell) = R(:,i_class,randperm(n_trials),i_cell);',pars.r_name,pars.p_type));
                    eval(sprintf('%sSN%s(:,i_class,:,i_cell) = %sS%s(:,i_class,randperm(n_trials),i_cell);',pars.r_name,pars.p_type,pars.r_name,pars.p_type));
                    
                end
            end
            
            %%
            Helper_Rename_Results
            
            new_result = 1;
        end
        
        One_Helper_Save_Results
        
    end
end

