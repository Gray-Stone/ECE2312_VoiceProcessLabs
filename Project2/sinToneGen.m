function [sinTone] = sinToneGen(sinFeq,length,fs)
%SINTONE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

n = 1/fs : 1/fs : length; 

n=transpose(n);

sinTone = sin(2 * pi * sinFeq * n);

end

