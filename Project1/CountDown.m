function [] = CountDown(Length)
%COUNTDOWN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
timerStep = 0.1;
for t=Length : -timerStep  :   0.0
   format long g   
   lineLength=fprintf('- -> Record start in %.1f second <- -', t);
   pause(0.1)
   fprintf(repmat('\b',1,lineLength))
end



end

