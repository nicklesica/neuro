%% Get valid indices
if two_sound_flag,
    IXA = intersect(eval(sprintf('IX_%s',sound_1)),...
        eval(sprintf('IX_%s',sound_2)));
else
    IXA = eval(sprintf('IX_%s',sound_1));
end

% clear(sprintf('IX_%s',sound_1),sprintf('IX_%s',sound_2));