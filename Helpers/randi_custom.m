function out = randi_custom(P,N,M)
%
%The function takes in a positive vector P whose values
%form a discrete probability distribution for the indices of P. The
%function outputs an N x M matrix of integers corresponding to the indices
%of P chosen at random from the given underlying distribution.
%
%P will be normalized, if it is not normalized already. Both N and M must
%be greater than or equal to 1. 

%normalize P
Pnorm=[0 P]/sum(P);
%create cumlative distribution
Pcum=cumsum(Pnorm);
%create random matrix
N=round(N);
M=round(M);
R=rand(1,N*M);
%calculate T output matrix
V=1:length(P);
[~,inds] = histc(R,Pcum); 
out = V(inds);
%shape into output matrix
out=reshape(out,N,M);