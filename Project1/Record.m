function [recObj ] = Record(recObj,recLength)
%RECORD take the record object and start the record and display count down
%for recLength of seconds

record(recObj)
sLength = fprintf("- -> Recording for %d seconds || ", recLength); 


% timer for pausing
timerStep = 0.1;
for t=0.0 : timerStep  :  recLength 
   format long g   
   lineLength=fprintf(' %.1fs left ||', t);
   pause(0.1)
   fprintf(repmat('\b',1,lineLength))
end

fprintf(repmat('\b',1,sLength))

stop(recObj);
disp("---  record ended  --- ")
% recording done

end

