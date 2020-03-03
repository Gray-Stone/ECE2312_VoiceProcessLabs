function [filteredSig] = FIRLowPass(sig, fs, passBand,stopBand)
%FIRFILITER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

% Filtering

F=[ 0 passBand   stopBand fs/2] ; % frequency up to nyquist frequency
F = F/(fs/2) ; % normalize to 1

A=[1 1 0 0];
N = 500 ; % order
b = firls(N,F,A);
filteredSig = filter(b,1,sig);

end

