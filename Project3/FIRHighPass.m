function [filteredSig] = FIRHighPass(sig, fs, stopBand, passBand )
%FIRFILITER 此处显示有关此函数的摘要
%   此处显示详细说明

% Filtering

F=[ 0 stopBand passBand    fs/2] ; % frequency up to nyquist frequency
F = F/(fs/2) ; % normalize to 1

A=[0 0 1 1 ];
N = 500 ; % order
b = firls(N,F,A);
filteredSig = filter(b,1,sig);

end

