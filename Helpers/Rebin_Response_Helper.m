function out = Rebin_Response_Helper(in,ratio,offset)
%Bins have to be the first dimension!
%ratio is 2 to double the bin size, 3 to triple it, etc.

if ratio>1,
    
    if nargin<3,
        offset=0;
    end
    
    [N,I]=size(in);
    
    if offset,
        in=[zeros(offset,I)>0;in];
    end
    
    [N,I]=size(in);
    if rem(N,ratio),
        in(end+1:end+ratio-rem(N,ratio),:)=0;
    end
    out=squeeze(nansum(reshape(full(in),ratio,[],I)));
    
else
    out=in;
end