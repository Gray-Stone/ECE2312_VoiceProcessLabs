function [downedData] = downIntSample(intputData,downRatio)
%DOWNINTSAMPLE 此处显示有关此函数的摘要
%   此处显示详细说明
    downedLength = fix(length(intputData)/downRatio);
    downedData(1:downedLength ,1) =0;
    for ii =1:1:downedLength
       downedData(ii , 1) = intputData( (ii-1)*downRatio +1 ,1) ;
    end
end

