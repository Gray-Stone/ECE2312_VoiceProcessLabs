function [uppedData] = UpIntSample(intputData,upRatio)
%UPINTSAMPLE 此处显示有关此函数的摘要
%   此处显示详细说明
    uppedLength = length(intputData) * upRatio;
    uppedData(1:uppedLength ,1) =0;
    for ii =1:1:uppedLength
       
        if mod ((ii-1) , upRatio) == 0
            uppedData(ii , 1) = intputData(  (ii-1) / upRatio +1 ,1) ;
        else 
            uppedData(ii,1) = 0;
        end
    
    end

end

