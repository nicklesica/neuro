function out = Rebin_Response(in,ratio)
%Bins have to be the first dimension!

if ratio > 1,
    
    sz = size(in);
    
    in = reshape(in,sz(1),[]);
    
    if rem(sz(1),ratio),
        in(end+1:end+ratio-rem(sz(1),ratio),:) = 0;
    end
    
    sz1 = size(in);
    
    out = squeeze(sum(reshape(in,ratio,[],sz1(2))));
    
    if size(out,1) == 1,
        out = out';
    end
    
    sz(1) = size(out,1);
    
    out = reshape(out,sz);
    
else
    
    out = in;
    
end