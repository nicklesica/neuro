function One_FRA_Analysis(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'FRA_Analysis';
out_vars = {'IXA','FRA','RLF','BF','CF','THR','Q','LEVELS','FREQS'};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);

Make_Out_Var_String

mkdir(out_dir)

%%
% date_1

% sound_1

load(sprintf('%s/%s/%s.mat',evalin('base','database_dir'),sub_dir,date_1),sprintf('*_%s',sound_1));

if exist(sprintf('R_%s',sound_1)) == 1,
    
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
        
        dt = pars.rearrange0.rebin/pars.fs;
        
        ix_bins = [find(dt:dt:1>pars.tones.t_min,1):...
            find(dt:dt:1>pars.tones.t_max,1)];
        
        FRA = squeeze(sum(mean(R(ix_bins,1:end-1,:,:,:),4)));
        
        RLF = squeeze(sum(FRA,1));
        
        [~,BF] = max(abs(squeeze(sum(FRA,2))));
        
        CF = zeros(1,n_cells);
        THR = zeros(1,n_cells);
        Q = zeros(1,n_cells);
        
        counts = squeeze(sum(sum(R(ix_bins,1:end-1,:,:,:),4)));
        
        lambda = squeeze(mean(sum(sum(R(ix_bins,end,:,:,:),4)),3));
        lambda = max(lambda,1/size(counts,2)); %Lower bound for spont rate
        
        for i_cell = 1:length(IXA),
            p = poisspdf(counts(:,:,IXA(i_cell)),lambda(IXA(i_cell)));
            sig = p < pars.tones.p_sig;
            thr = find(sum(sig),1);
            if ~length(thr),
                thr = NaN;
                cf = NaN;
            else
                [~,cf] = max(FRA(:,thr,IXA(i_cell)));
            end
            THR(IXA(i_cell)) = thr;
            CF(IXA(i_cell)) = cf;
            
            try
                temp = counts(:,THR(IXA(i_cell))+2,IXA(i_cell));
                temp = overMaxReps(temp);
                temp = interp1(1:size(temp,1),temp,1:(1/pars.tones.tun_interp):size(temp,1));
                temp = temp > 0.5;
                
                Q(IXA(i_cell)) = (pars.tones.f_step_octave/pars.tones.tun_interp)*sum(temp)+0.5*(pars.tones.f_step_octave/pars.tones.tun_interp);
            catch
                Q(IXA(i_cell)) = NaN;
            end
        end
        
        temp = load(pars.rearrange0.stim_file);
        
        BF(find(BF>0)) = temp.freqs(BF(find(BF>0)));
        CF(find(CF>0)) = temp.freqs(CF(find(CF>0)));
        THR(find(THR>0)) = temp.levels(THR(find(THR>0)));
        
        LEVELS = repmat(temp.levels(:),1,n_cells);
        FREQS = repmat(temp.freqs(:),1,n_cells);
        
        %%
        Helper_Rename_Results
        
        new_result = 1;
    end
    
    One_Helper_Save_Results
    
end

