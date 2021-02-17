function One_Victor_Dist(sound_1,date_1,pars,sound_2,date_2)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Victor_Dist';
out_vars = {'IXA','DIST'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

Make_Out_Var_String

% mkdir(out_dir)

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
        
        out_dir = sprintf('%s_%s_%s',out_dir,pars.p_type,pars.r_name);
        
        mkdir(out_dir)

        R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses','R');
        
        % Combine different talkers and vowels (or consonants)
        if ndims(R) == 5,
            R = reshape(R,size(R,1),size(R,2),size(R,3)*size(R,4),size(R,5));
        end
        
        dt = pars.rebin/pars.fs;
        
        ix_bins = [find(dt:dt:1>pars.t_min_counts,1):...
            find(dt:dt:1>pars.t_max_counts,1)];
        
        R = squeeze(R(ix_bins,pars.ix_classes,:,:,:));
        
        [n_bins,n_classes,n_trials,n_cells] = size(R);
        
        DIST = zeros(n_classes*n_trials,n_classes*n_trials,length(pars.taus),n_cells);
        
        sts = cell(n_classes,n_trials,n_cells);
        
        for i_1 = 1:size(sts,1),
            for i_2 = 1:size(sts,2),
                for i_3 = 1:size(sts,3),
                    sts{i_1,i_2,i_3} = find(R(:,i_1,i_2,i_3))*dt;
                end
            end
        end
        
        for i_cell = 1:length(IXA),
            
            these_sts = sts(:,:,i_cell);
            
            these_counts = sum(R(:,:,:,i_cell));
            
            if any(these_counts(:)),
                
                these_sts = Reshape_Spike_Times_For_Victor_Decoding(these_sts);
                
                DIST(:,:,:,i_cell) = Setup_Victor_Decoding(these_sts,0,pars.t_max_counts-pars.t_min_counts,pars.taus);
                
            end
        end
        
        DIST = single(DIST); %To save space, but is this causing problems?
        
        %%
        Helper_Rename_Results
        
        new_result = 1;
    end
    
    One_Helper_Save_Results
    
end

