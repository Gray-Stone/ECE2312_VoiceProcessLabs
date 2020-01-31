function [] = CountDown(Length)
%COUNTDOWN 此处显示有关此函数的摘要
%   此处显示详细说明
timerStep = 0.1;
for t=Length : -timerStep  :   0.0
   format long g   
   lineLength=fprintf('- -> Record start in %.1f second <- -', t);
   pause(0.1)
   fprintf(repmat('\b',1,lineLength))
end



end

