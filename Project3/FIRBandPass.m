function [filteredSig] = FIRBandPass(sig, fs, LowFeq,HighFeq)
%FIRFILITER 此处显示有关此函数的摘要
%   此处显示详细说明

% Filtering
transitionBand = 2 % Hz 
if fs < HighFeq + transitionBand +1 
    HighFeq = fs -transitionBand  - 1 ;
end 

F=[ 0 LowFeq-2 LowFeq  HighFeq  HighFeq+2 fs/2] ; % frequency up to nyquist frequency
F = F/(fs/2) ; % normalize to 1

A=[0 0 1 1 0 0 ];
N = 10000 ; % order
b = firls(N,F,A);
filteredSig = filter(b,1,sig);

end

