function One_Counts_Rearrange(sound_1,date_1,pars)

%% Setup - edit this
sub_dir = 'All_1ms';
out_dir_name = 'Rearranged_Responses';
out_vars = {strcat('C',pars.p_type)};

%%
two_sound_flag = nargin>3;

var_name_str = 'sound_1';

out_dir = sprintf('%s\\%s',evalin('base','database_analysis_dir'),out_dir_name);

Make_Out_Var_String

mkdir(out_dir)

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
                
                case {'CV12','VC8'}
                    
                    R = reshape(R,size(R,1),size(R,2),size(R,3)*size(R,4),size(R,5));
                    
                    dt = pars.rearrange0.rebin/pars.fs;
                    
                    ix_bins = [find(dt:dt:1>pars.counts.t_min,1):...
                        find(dt:dt:1>pars.counts.t_max,1)];
                    
                    eval(sprintf('C%s = sum(R(ix_bins,pars.counts.ix_classes,:,:));',pars.p_type));
                    
                case 'CV12D'
                    
                    R = reshape(R,size(R,1),size(R,2),size(R,3)*size(R,4),size(R,5));
                    
                    dt = pars.rearrange0.rebin/pars.fs;
                    
                    ix_bins = [find(dt:dt:1>pars.counts.t_min,1):...
                        find(dt:dt:1>pars.counts.t_max,1)];
                    
                    R = sum(R(ix_bins,pars.counts.ix_classes,:,:));
                    
                    temp = reshape(R(:,1:end/2,:,:),[size(R,1) 1 size(R,2)/2*size(R,3) size(R,4)]);
                    temp(:,2,:,:) = reshape(R(:,end/2+1:end,:,:),[size(R,1) 1 size(R,2)/2*size(R,3) size(R,4)]);
                    
                    eval(sprintf('C%s = temp;',pars.p_type));
                    
                case {'PST9','CVR12'}
                    
                    dt = pars.rearrange0.rebin/pars.fs;
                    
                    ix_bins = [find(dt:dt:1>pars.counts.t_min,1):...
                        find(dt:dt:1>pars.counts.t_max,1)];
                    
                    eval(sprintf('C%s = sum(R(ix_bins,pars.counts.ix_classes,:,:));',pars.p_type));
                    
                    
                case {'MR16'}
                    
                    R = Rebin_Response(R,pars.rearrange.rebin);
                    
                    dt = (pars.rearrange0.rebin/pars.fs)*pars.rearrange.rebin;
                    
                    ix_bins = [find(dt:dt:1>pars.rearrange.t_min,1):...
                        find(dt:dt:1>pars.rearrange.t_max,1)];
                    
                    R = sum(R(ix_bins,:,:,:,:,:));
                    
                    temp = reshape(R(:,:,1,:,:,:),size(R,1),16,size(R,5),size(R,6));
                    eval(sprintf('C%s05 = temp;',pars.p_type));
                    
                    temp = reshape(R(:,:,2,:,:,:),size(R,1),16,size(R,5),size(R,6));
                    eval(sprintf('C%s15 = temp;',pars.p_type));
                    
                    temp = reshape(R(:,:,3,:,:,:),size(R,1),16,size(R,5),size(R,6));
                    eval(sprintf('C%s25 = temp;',pars.p_type));
                    
                    temp = reshape(R(:,:,4,:,:,:),size(R,1),16,size(R,5),size(R,6));
                    eval(sprintf('C%s35 = temp;',pars.p_type));
                    
                    out_vars = {sprintf('C%s05',pars.p_type),sprintf('C%s15',pars.p_type),sprintf('C%s25',pars.p_type),sprintf('C%s35',pars.p_type)};
                    out_var_str = '''CMR1605_*'',''CMR1615_*'',''CMR1625_*'',''CMR1635_*''';
                    
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



