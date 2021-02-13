folder = 'D:\Dropbox\Nick\Other\Database_Analysis\Rearranged_Responses';
file_strs = {
    'TLDC*'
    'TLDS*'
    'TLDN*'
    };

mat_files = dir(sprintf('%s\\*.mat',folder))

for i_file = 1:length(mat_files),
    
    mat_files(i_file).name
    
    for i_str = 1:length(file_strs),
        
        vars = whos('-file',sprintf('%s\\%s',folder,mat_files(i_file).name),file_strs{i_str});
        
        to_delete = {};
        
        for i_var = 1:length(vars),
            
            vars(i_var).name
            
            to_delete{end+1} = vars(i_var).name;
            
        end
        
        temp = rmfield(load(sprintf('%s\\%s',folder,mat_files(i_file).name)),to_delete);
        save(sprintf('%s\\%s',folder,mat_files(i_file).name),'-struct','temp');
        
    end
end

% error(nargchk(2,inf,nargin));
% vars = rmfield(load(filename),varargin(:));
% save(filename,'-struct','vars');