function [sinTone] = sinToneGen(sinFeq,length,fs)
%SINTONE 此处显示有关此函数的摘要
%   此处显示详细说明

n = 1/fs : 1/fs : length; 

n=transpose(n);

sinTone = sin(2 * pi * sinFeq * n);

end

