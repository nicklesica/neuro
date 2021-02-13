function One_Coherence_Noise_Nuisance(sound_1,date_1,pars,sound_2,date_2)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Coherence_Noise_Nuisance';
out_vars = {'PARS','IXA','PSD1','PSD2','COH','CSD','COHSHUFF','CSDSHUFF','COHS','CSDS','COH0','CSD0','COHSIG','CSDSIG','COHSHUFFSIG','CSDSHUFFSIG','COHSSIG','CSDSSIG','F'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sprintf(''%s_%s'',sound_1,sound_2)';

out_dir = sprintf('%s\\Nick\\Other\\Database_Analysis\\%s',evalin('base','dropbox_dir'),out_dir_name);

mkdir(out_dir)

Make_Out_Var_String

%%
% date_1

% sound_1

Check_For_Existing_Results

if (length(existing_results) ~= length(out_vars)) | pars.overwrite == 1,
    
    load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_1));
    
    if two_sound_flag,
        
        load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_2));
        cond =  exist(sprintf('R_%s',sound_1)) & exist(sprintf('R_%s',sound_2));
        
    else
        
        cond =  exist(sprintf('R_%s',sound_1));
        
    end
    
    if cond,
        fprintf('Writing\n');
        
        new_result = 0;
        
        One_Helper_Get_These_Responses
        
        One_Helper_Get_Valid_Indices
        
        if length(IXA),
            
            r_1 = r_1(:,IXA);
            
            if two_sound_flag,
                r_2 = r_2(:,IXA);
            end
            
            %% Do calculations - edit this
            
            % Sound 1
            n_cells_0 = size(eval(sprintf('R_%s',sound_1)),2);
            
            r_1 = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses','R0');
            
            switch pars.p_type,
                case 'CV12'
                    r_1 = reshape(r_1,size(r_1,1),size(r_1,2),size(r_1,3)*size(r_1,4),size(r_1,5));
            end
            
            r_1 = Rebin_Response(r_1,pars.coh.rebin);
            
            dt = (pars.rearrange0.rebin/pars.fs)*pars.coh.rebin;
            
            ix_bins = [find(dt:dt:1>pars.coh.t_min,1):...
                find(dt:dt:1>pars.coh.t_max,1)];
            
            r_1 = r_1(ix_bins,pars.coh.ix_classes,:,IXA);
            
            [n_bins,n_classes,n_trials,n_cells] = size(r_1);
            
            % Sound 2, if needed
            if two_sound_flag,
                
                r_2 = Get_Database_Analysis({date_2},sound_2,'Rearranged_Responses','R0');
                
                switch pars.p_type,
                    case 'CV12'
                        r_2 = reshape(r_2,size(r_2,1),size(r_2,2),size(r_2,3)*size(r_2,4),size(r_2,5));
                end
                
                r_2 = Rebin_Response(r_2,pars.coh.rebin);
                r_2 = r_2(ix_bins,pars.coh.ix_classes,:,IXA);
                
            else
                
                sound_2 = sound_1;
                r_2 = r_1;
                
            end
            
            % With and without class shuffling
            [f,psd_1,psd_2,coh,csd,coh_shuff,csd_shuff,coh_0,csd_0] = Calc_Coherence_Database(reshape(r_1,[],n_cells),reshape(r_2,[],n_cells),pars.coh);
            
            coh_shuff = mean(coh_shuff,3);
            csd_shuff = mean(csd_shuff,3);
            
            coh_0 = sort(coh_0,3);
            coh_0 = coh_0(:,:,ceil((pars.coh.sig_pct/100)*end));
            
            csd_0 = sort(csd_0,3);
            csd_0 = csd_0(:,:,ceil((pars.coh.sig_pct/100)*end));
            
            % With trial shuffling
            for i_shuff = 1:pars.coh.n_shuff_trials,
                
                ix = Shuffle(size(r_2,3),'derange',size(r_2,3));
                
                r_2_shuff = r_2(:,:,ix,:);
                
                [~,~,~,cohs(:,:,i_shuff),csds(:,:,i_shuff)] = Calc_Coherence_Database(reshape(r_1,[],n_cells),reshape(r_2_shuff,[],n_cells),pars.coh);
                
            end
            
            cohs = mean(cohs,3);
            csds = mean(csds,3);
            
            
            PSD1 = zeros(length(f),n_cells_0);
            PSD2 = zeros(length(f),n_cells_0);
            
            PSD1(:,IXA) = psd_1;
            PSD2(:,IXA) = psd_2;
            
            
            CSD = zeros(length(f),n_cells_0);
            CSDS = zeros(length(f),n_cells_0);
            CSDSHUFF = zeros(length(f),n_cells_0);
            CSD0 = zeros(length(f),n_cells_0);
            
            COH = zeros(length(f),n_cells_0);
            COHS = zeros(length(f),n_cells_0);
            COHSHUFF = zeros(length(f),n_cells_0);
            COH0 = zeros(length(f),n_cells_0);
            
            CSD(:,IXA) = csd;
            CSDS(:,IXA) = csds;
            CSDSHUFF(:,IXA) = csd_shuff;
            CSD0(:,IXA) = csd_0;
            
            COH(:,IXA) = coh;
            COHS(:,IXA) = cohs;
            COHSHUFF(:,IXA) = coh_shuff;
            COH0(:,IXA) = coh_0;
            
            
            CSDSIG = zeros(length(f),n_cells_0);
            CSDSSIG = zeros(length(f),n_cells_0);
            CSDSHUFFSIG = zeros(length(f),n_cells_0);
            
            COHSIG = zeros(length(f),n_cells_0);
            COHSSIG = zeros(length(f),n_cells_0);
            COHSHUFFSIG = zeros(length(f),n_cells_0);
            
            CSDSIG(:,IXA) = csd.*(csd>csd_0);
            CSDSSIG(:,IXA) = csds.*(csds>csd_0);
            CSDSHUFFSIG(:,IXA) = csd_shuff.*(csd_shuff>csd_0);
            
            COHSIG(:,IXA) = coh.*(coh>coh_0);
            COHSSIG(:,IXA) = cohs.*(cohs>coh_0);
            COHSHUFFSIG(:,IXA) = coh_shuff.*(coh_shuff>coh_0);
            
            
            F = f;
            PARS = pars;
            
            %%
            two_sound_flag = 1;
            
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




