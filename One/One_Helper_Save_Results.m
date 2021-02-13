%% Save results
if new_result,
    if exist(sprintf('%s\\%s.mat',out_dir,date_1)),
        eval(sprintf('save(''%s\\%s.mat'',%s,''BLK_*'',''-append'');',out_dir,date_1,out_var_str));
    else
        eval(sprintf('save(''%s\\%s.mat'',%s,''BLK_*'',''-v7.3'');',out_dir,date_1,out_var_str));
    end
end