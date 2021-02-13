function One_Dist_Victor(sound_1,date_1,pars,sound_2,date_2)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = sprintf('Dist_Victor_%s_%s',pars.p_type,pars.r_name);
out_vars = {'IXA','DIST'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

mkdir(out_dir)

Make_Out_Var_String

% mkdir(out_dir)

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
        
        switch pars.p_type
            case 'CV12'
                R = reshape(R,size(R,1),size(R,2),size(R,3)*size(R,4),size(R,5));
                
        end
        
        dt = (pars.rearrange0.rebin/pars.fs);
        
        ix_bins = [find(dt:dt:1>pars.rearrange.t_min,1):...
            find(dt:dt:1>pars.rearrange.t_max,1)];
        
        R = R(ix_bins,pars.rearrange.ix_classes,:,:);
        
        [n_bins,n_classes,n_trials,n_cells] = size(R);
        
        %         R = permute(R,[1 3 2 4]); % So that DIST is grouped by classes
        
        DIST = zeros(n_classes*n_trials,n_classes*n_trials,length(pars.dist.taus),n_cells);
        
        dt = pars.rearrange0.rebin/pars.fs;
        
        sts = cell(n_classes,n_trials,n_cells);
        
        for i_1 = 1:size(sts,1),
            for i_2 = 1:size(sts,2),
                for i_3 = 1:size(sts,3),
                    sts{i_1,i_2,i_3} = find(R(:,i_1,i_2,i_3))*dt;
                end
            end
        end
        
        for i_cell = 1:length(IXA),
            
            these_sts = sts(:,:,IXA(i_cell));
            
            these_counts = sum(R(:,:,:,IXA(i_cell)));
            
            if any(these_counts(:)),
                
                these_sts = Reshape_Spike_Times_For_Victor_Decoding(these_sts);
                
                DIST(:,:,:,IXA(i_cell)) = Setup_Victor_Decoding(these_sts,0,dt*n_bins,pars.dist.taus);
                
            end
        end
        
        DIST = single(DIST); %To save space, but is this causing problems?
        
        
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


