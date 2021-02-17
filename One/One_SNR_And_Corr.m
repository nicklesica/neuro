function One_SNR_And_Corr(sound_1,date_1,pars,sound_2,date_2)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = sprintf('SNR_And_Corr_%s_%s',pars.p_type,pars.r_name);
out_vars = {'IXA','VARS','VARN','GVARS','GVARN','CSIG','CNOISE','RVSIG','RVNOISE'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);

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
        
        new_result = 0;
        
        One_Helper_Get_These_Responses
        
        One_Helper_Get_Valid_Indices
        
        %% Do calculations - edit this
        R = Get_Database_Analysis({date_1},sound_1,'Rearranged_Responses',sprintf('%s%s',pars.r_name,pars.p_type));
        
        [n_bins,n_classes,n_trials,n_cells] = size(R);
        
        if min(size(R)),
            
            fprintf('Writing\n');
            
            sig = squeeze(mean(R,3));
            
            if ndims(sig) == 2,
                
                sig = permute(sig,[3 1 2]);
                
            end
            
            noise = R - repmat(permute(sig,[1 2 4 3]),1,1,n_trials,1);
            
            noise = reshape(noise,n_bins,[],n_cells);
            
            % Signal
            
            VARS = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                VARS(i_bin,:) = var(squeeze(sig(i_bin,:,:)));
                
            end
            
            GVARS = zeros(1,n_cells);
            
            for i_cell = 1:n_cells,
                
                GVARS(i_cell) = det(cov(sig(:,:,i_cell)'));
                
            end
            
            % Noise
            
            VARN = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                VARN(i_bin,:) = var(squeeze(noise(i_bin,:,:)));
                
            end
            
            GVARN = zeros(1,n_cells);
            
            for i_cell = 1:n_cells,
                
                GVARN(i_cell) = det(cov(noise(:,:,i_cell)'));
                
            end
            
            % Signal
            
            CSIG = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                temp = corr(squeeze(sig(i_bin,:,:)));
                
                CSIG(i_bin,:) = nanmean(NaN_Diagonals_In_3D_Matrix(temp))';
                
            end
            
            RVSIG = zeros(1,n_cells);
            
            for i_cell_1 = 1:n_cells,
                
                temp = zeros(1,n_cells);
                
                for i_cell_2 = 1:n_cells,
                    
                    temp(i_cell_2) = Calc_RV_Coefficient(sig(:,:,i_cell_1)',sig(:,:,i_cell_2)');
                    
                end
                
                temp(i_cell_1) = NaN;
                
                RVSIG(i_cell_1) = nanmean(temp);
                
            end
            
            % Noise
            
            CNOISE = zeros(n_bins,n_cells);
            
            for i_bin = 1:n_bins,
                
                temp = corr(squeeze(noise(i_bin,:,:)));
                
                CNOISE(i_bin,:) = nanmean(NaN_Diagonals_In_3D_Matrix(temp))';
                
            end
            
            RVNOISE = zeros(1,n_cells);
            
            for i_cell_1 = 1:n_cells,
                
                temp = zeros(1,n_cells);
                
                for i_cell_2 = 1:n_cells,
                    
                    temp(i_cell_2) = Calc_RV_Coefficient(noise(:,:,i_cell_1)',noise(:,:,i_cell_2)');
                    
                end
                
                temp(i_cell_1) = NaN;
                
                RVNOISE(i_cell_1) = nanmean(temp);
                
            end
            
            %%
            Helper_Rename_Results
            
            new_result = 1;
            
            One_Helper_Save_Results
        else
            fprintf('Skipping because modified responses are not there\n');
        end
    else
        fprintf('Skipping because original responses are not there\n');
    end
else
    fprintf('Skipping because results are already there\n');
end


