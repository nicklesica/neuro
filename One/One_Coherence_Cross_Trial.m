function One_Coherence_Cross_Trial(sound_1,date_1,pars,sound_2,date_2)

%% Setup - edit this
sub_dir = 'All_1ms';
if isfield(pars.coh,'out_dir_name');
    out_dir_name = pars.coh.dir;
else
    out_dir_name = 'Coherence_Cross_Trial';
end
out_vars = {'PARS','IXA','PSD1','PSD2','COH','CSD','COH0','CSD0','COHSIG','CSDSIG','F'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sprintf(''%s_%s'',sound_1,sound_2)';

out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);

mkdir(out_dir)

Make_Out_Var_String

%%
% date_1

% sound_1

Check_For_Existing_Results

if (length(existing_results) ~= length(out_vars)) | pars.overwrite == 1,
    
    load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_1));
    load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_2));
    
    if exist(sprintf('R_%s',sound_1)) == 1 & exist(sprintf('R_%s',sound_2)) == 1,
        
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
            n_cells = size(eval(sprintf('R_%s',sound_1)),2);
            
            r_1 = Rebin_Response(r_1,pars.coh.rebin);
            r_2 = Rebin_Response(r_2,pars.coh.rebin);
            
            [f,psd_1,psd_2,coh,csd,coh_0,csd_0] = Calc_Coherence_Database(r_1,r_2,pars.coh);
            
            coh_0 = sort(coh_0,3);
            ix = floor(pars.coh.alpha*size(coh_0,3))
            coh_0 = coh_0(:,:,ix); %95 level for n_shuff = 20;
            
            csd_0 = sort(csd_0,3);
            csd_0 = csd_0(:,:,ix); %95 level for n_shuff = 20;
            
            PSD1 = zeros(length(f),n_cells);
            PSD2 = zeros(length(f),n_cells);
            
            PSD1(:,IXA) = psd_1;
            PSD2(:,IXA) = psd_2;
            
            
            CSD = zeros(length(f),n_cells);
            CSD0 = zeros(length(f),n_cells);
            
            COH = zeros(length(f),n_cells);
            COH0 = zeros(length(f),n_cells);
            
            CSD(:,IXA) = csd;
            CSD0(:,IXA) = csd_0;
            
            COH(:,IXA) = coh;
            COH0(:,IXA) = coh_0;
            
            
            CSDSIG = zeros(length(f),n_cells);
            
            COHSIG = zeros(length(f),n_cells);
            
            CSDSIG(:,IXA) = csd.*(csd>csd_0);
            
            COHSIG(:,IXA) = coh.*(coh>coh_0);
            
            F = f;
            PARS = pars;
            
            
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




