function [out,ix_valid,blocks,dates] = Get_Database_Analysis_By_Experiment(date_list,var_name_str,dir_str,var_str)

% two_sounds = (nargin>4);

dbase_dir = strcat( evalin('base','dropbox_dir'),'\Nick\Other\Database_Analysis');
dbase_dir = sprintf('%s\\%s',dbase_dir,dir_str);

warning('off','MATLAB:load:variableNotFound')
warning('off','MATLAB:load:variablePatternNotFound')

var_str = sprintf('%s_%s',var_str,var_name_str);

temp = [];
i_date = 0;

% Find the first date that actually has this field and read it
while isempty(temp) & i_date<length(date_list),
    
    i_date = i_date + 1;
    
    try
        load(sprintf('%s/%s.mat',dbase_dir,date_list{i_date}),var_str);
    end
    
    if exist(var_str),
        temp = eval(var_str);
    end
end

out0 = temp;
clear temp

%Now read all dates and fill in blanks where this field is not present
for i_date = 1:length(date_list),
    
    clear(sprintf('*_%s',var_name_str))
    
    try
        load(sprintf('%s/%s.mat',dbase_dir,date_list{i_date}),sprintf('*_%s',var_name_str));
    end
    
    if exist(var_str),
        
        temp = eval(var_str);
        
%         try
%             ix_temp = eval(sprintf('IXA_%s',var_name_str));
%             blocks_temp = eval(sprintf('BLK_%s',var_name_str));
%             if size(blocks_temp,1) == 1,
%                 blocks_temp(2,:) = NaN;
%             end
%         catch
%             ix_temp = 1:size(temp,ndims(temp));
%             blocks_temp = zeros(2,length(ix_temp));
%         end
%         dates_temp = str2num(date_list{i_date})*ones(1,size(blocks_temp,2));
        
    else
        
%         n_cells = evalin('base',sprintf('database_n_cells(database_dates==%s)',date_list{i_date}));
        
        sz = size(out0);
%         sz = [sz(1:end-1) n_cells];
        temp = zeros(sz,class(out0));
        
%         ix_temp = [];
%         blocks_temp = NaN(2,n_cells);
%         dates_temp = str2num(date_list{i_date})*ones(1,size(blocks_temp,2));
        
    end
    
    if exist('out'),
%         ix_valid = [ix_valid cells_so_far+ix_temp];
%         try
%             blocks = cat(ndims(blocks),blocks,blocks_temp);
%         catch
%             blocks_temp(2,:) = NaN;
%             blocks = cat(ndims(blocks),blocks,blocks_temp);
%         end
%         dates = cat(ndims(dates),dates,dates_temp);
%         
%         
%         str = 'out(';
%         for i_dim = 1:length(sz)-1,
%             str = sprintf('%s:,',str);
%         end
%         str = sprintf('%s(cells_so_far+1):(cells_so_far+size(temp,ndims(temp)))) = temp;',str);
%         eval(str);
%         
%         cells_so_far = cells_so_far+size(temp,ndims(temp));
        
        
                out = cat(ndims(out0)+1,out,temp);
        
    else
        
%         sz = size(temp);
%         
%         str = 'out = zeros(';
%         for i_dim = 1:length(sz)-1,
%             str = sprintf('%s%d,',str,sz(i_dim));
%         end
%         str = sprintf('%sn_cells_all);',str);
%         eval(str);
%         
%         
%         str = 'out(';
%         for i_dim = 1:length(sz)-1,
%             str = sprintf('%s:,',str);
%         end
%         str = sprintf('%s1:size(temp,ndims(temp))) = temp;',str);
%         eval(str);
%         
%         cells_so_far = size(temp,ndims(temp));
        
                out = temp;
        
%         ix_valid = ix_temp;
%         blocks = blocks_temp;
%         
%         dates = dates_temp;
    end
end