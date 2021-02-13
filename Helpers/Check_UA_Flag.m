function flag = Check_UA_Flag

flag = 0;
if evalin('caller','exist(''pars'')'),
    if evalin('caller','isfield(pars,''read'')'),
        if evalin('caller','isfield(pars.read,''ua_flag'')'),
            if evalin('caller','pars.read.ua_flag'),
                flag = 1;
            end
        end
    end
end


