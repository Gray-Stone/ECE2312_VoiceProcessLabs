function [downedData] = downIntSample(intputData,downRatio)
%DOWNINTSAMPLE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    downedLength = fix(length(intputData)/downRatio);
    downedData(1:downedLength ,1) =0;
    for ii =1:1:downedLength
       downedData(ii , 1) = intputData( (ii-1)*downRatio +1 ,1) ;
    end
end

