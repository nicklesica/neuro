function One_Counts_Noise_Nuisance(sound_1,date_1,pars,sound_2,date_2)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Counts_Noise_Nuisance';
out_vars = {'PARS','IXA','PSD1','PSD2','COH','CSD','COHS','CSDS','COH0','CSD0','COHSIG','CSDSIG','COHSSIG','CSDSSIG','NI','NU','NI1','NU1'};

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
            
            %             r_1 = r_1(:,IXA);
            %
            %             if two_sound_flag,
            %                 r_2 = r_2(:,IXA);
            %             end
            
            %% Do calculations - edit this
            
            % Sound 1
            n_cells_0 = size(eval(sprintf('R_%s',sound_1)),2);
            
            r_1 = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',strcat(pars.r_name,pars.p_type));
            
            [n_bins,n_classes,n_trials,n_cells] = size(r_1);
            
            % Sound 2, if needed
            if two_sound_flag,
                
                r_2 = Get_Database_Analysis({date_2},sound_2,'Rearranged_Responses',strcat(pars.r_name,pars.p_type));
                
            else
                
                sound_2 = sound_1;
                r_2 = r_1;
                
            end
            
            % With and without class shuffling
            psd_1 = var(reshape(r_1,[],n_cells));
            psd_2 = var(reshape(r_2,[],n_cells));
            csd = mean((reshape(r_1,[],n_cells)-mean(reshape(r_1,[],n_cells))).*(reshape(r_2,[],n_cells)-mean(reshape(r_2,[],n_cells))));
            
            csd = max(csd,1/(n_classes*n_trials));
            
            %             coh = abs(csd)./sqrt(psd_1.*psd_2);
            coh = csd./sqrt(psd_1.*psd_2);
            
            for i_shuff = 1:pars.coh.n_shuff,
                
                ix = Shuffle(size(r_2,3),'derange',size(r_2,3));
                
                r_2_shuff = r_2(:,:,ix,:);
                
                csd_s(:,:,i_shuff) = mean((reshape(r_1,[],n_cells)-mean(reshape(r_1,[],n_cells))).*(reshape(r_2_shuff,[],n_cells)-mean(reshape(r_2_shuff,[],n_cells))));
                
                ix = Shuffle(size(r_2,2),'derange',size(r_2,2));
                
                r_2_shuff = r_2_shuff(:,ix,:,:);
                
                csd_0(:,:,i_shuff) = mean((reshape(r_1,[],n_cells)-mean(reshape(r_1,[],n_cells))).*(reshape(r_2_shuff,[],n_cells)-mean(reshape(r_2_shuff,[],n_cells))));
                
            end
            
            csd_s = mean(csd_s,3);
            
            csd_s = max(csd_s,1/(n_classes*n_trials));
            
            %             coh_s = abs(csd_s)./sqrt(psd_1.*psd_2);
            coh_s = csd_s./sqrt(psd_1.*psd_2);
            
            csd_0 = sort(csd_0,3);
            csd_0 = csd_0(:,:,ceil((pars.coh.sig_pct/100)*end));
            
            csd_0 = max(csd_0,1/(n_classes*n_trials));
            
            
            %             coh_0 = abs(csd_0)./sqrt(psd_1.*psd_2);
            coh_0 = csd_0./sqrt(psd_1.*psd_2);
            
            f = 0;
            
            PSD1 = zeros(length(f),n_cells_0);
            PSD2 = zeros(length(f),n_cells_0);
            
            PSD1 = psd_1;
            PSD2 = psd_2;
            
            
            CSD = zeros(length(f),n_cells_0);
            CSDS = zeros(length(f),n_cells_0);
            CSD0 = zeros(length(f),n_cells_0);
            
            COH = zeros(length(f),n_cells_0);
            COHS = zeros(length(f),n_cells_0);
            COH0 = zeros(length(f),n_cells_0);
            
            CSD = csd;
            CSDS = csd_s;
            CSD0 = csd_0;
            
            COH = coh;
            COHS = coh_s;
            COH0 = coh_0;
            
            CSDSIG = zeros(length(f),n_cells_0);
            CSDSSIG = zeros(length(f),n_cells_0);
            
            COHSIG = zeros(length(f),n_cells_0);
            COHSSIG = zeros(length(f),n_cells_0);
            
            CSDSIG = csd.*(csd>csd_0);
            CSDSSIG = csd_s.*(csd_s>csd_0);
            
            COHSIG = coh.*(coh>coh_0);
            COHSSIG = coh_s.*(coh_s>coh_0);
            
            NI = PSD1 - CSD;
            NU = CSD - CSDS;
            
            NI1 = 1 - COH;
            NU1 = COH - COHS;
            
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




