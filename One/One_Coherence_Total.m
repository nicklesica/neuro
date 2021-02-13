function One_Coherence_Total(sound_1,date_1,pars,sound_2,date_2)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = strcat(pars.coh.dir,'_Total');

out_vars = {'IXA','PARS','BLK','F'};

todo_vars = {};

try
    
    all_vars = whos('-file',sprintf('%s\\%s\\%s.mat',...
        evalin('base','database_analysis_dir'),pars.coh.dir,date_1),...
        sprintf('*_%s_%s',sound_1,sound_2));
    
    if length(all_vars),
        
        for i_var = 1:length(all_vars),
            this_var = all_vars(i_var).name;
            this_var = this_var(1:find(this_var=='_')-1);
            if ~ismember(this_var,{'BLK','IXA','F','PARS'}),
                todo_vars{end+1} = this_var;
                out_vars{end+1} = strcat(this_var,'TOT');
                %                 out_vars{end+1} = strcat(this_var,'ENV');
                %                 out_vars{end+1} = strcat(this_var,'PFS');
                
            end
        end
        
        %%
        two_sound_flag = nargin>3;
        
        var_name_str = 'sprintf(''%s_%s'',sound_1,sound_2)';
        
        out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);
        
        mkdir(out_dir)
        
        Make_Out_Var_String
        
        %%
        % date_1
        
        % sound_1
        
        %% Do calculations - edit this
        f = Get_Database_Analysis({date_1},sprintf('%s_%s',sound_1,sound_2),pars.coh.dir,'F');
        
        tot_rng = 1:length(f);
        %         tot_rng = find(f > pars.coh.f_tot(1) & f < pars.coh.f_tot(2));
        %         env_rng = find(f > pars.coh.f_env(1) & f < pars.coh.f_env(2));
        %         pfs_rng = find(f > pars.coh.f_pfs(1) & f < pars.coh.f_pfs(2));
        
        for i_var = 1:length(todo_vars),
            
            this_var = todo_vars{i_var};
            
            temp = Get_Database_Analysis({date_1},sprintf('%s_%s',sound_1,sound_2),pars.coh.dir,this_var);
            
            eval(sprintf('%sTOT = Get_Total_Coherence(temp,f,tot_rng);',this_var));
            %             eval(sprintf('%sENV = Get_Total_Coherence(temp,f,env_rng);',this_var));
            %             eval(sprintf('%sPFS = Get_Total_Coherence(temp,f,pfs_rng);',this_var));
            
        end
        
        F = Get_Database_Analysis({date_1},sprintf('%s_%s',sound_1,sound_2),pars.coh.dir,'F');
        
        IXA = load(sprintf('%s\\%s\\%s.mat',...
            evalin('base','database_analysis_dir'),pars.coh.dir,date_1),...
            sprintf('IXA_%s_%s',sound_1,sound_2));
        temp = fieldnames(IXA);
        IXA = eval(sprintf('IXA.%s',temp{1}));
        
        BLK = Get_Database_Analysis({date_1},sprintf('%s_%s',sound_1,sound_2),pars.coh.dir,'BLK');
        
        PARS = pars;
        
        %%
        Helper_Rename_Results
        
        new_result = 1;
        
        One_Helper_Save_Results
        
    else
        fprintf('Nothing to do for %s\n',date_1);
    end
catch
    fprintf('Nothing to do for %s\n',date_1);
end
