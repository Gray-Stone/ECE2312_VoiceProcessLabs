clear 
clc 


filename = "audioclip-1581903146-7894.wav";
[recData, fs] = audioread( filename );
recLength = length(recData);
speechFs =  16000 ;  % 8000 Hz for speech data, (sampling feq multiply by 2) the frequency choosen for speech frequency. 


% Plot origional data 
figure(1)
SpectrogramPlot(recData,fs);
title("Origional Signal");

% generate speech only
% filter and downsample to speech size

speechData = FIRLowPass(recData,fs , speechFs/2 - 1 , speechFs/2+1);
speechData = downIntSample(speechData,fs/speechFs);
figure(2); % plot 
SpectrogramPlot(  speechData , speechFs);
title("speach content only");



% split into 2 parts 

firstFoldFs = speechFs /2 ; 
LowSig = foldHalf( speechData, speechFs, true );
HighSig = foldHalf( speechData, speechFs, false);

figure(3) ; 
SpectrogramPlot(  LowSig , firstFoldFs);
title("0 - 4000 Hz signal  ");
figure(4) ; 
SpectrogramPlot(  HighSig , firstFoldFs);
title("4000 - 8000 Hz signal (notice the flip)  ");


% Split into 4 parts 

secondFoldFs = firstFoldFs/2;
LowSigLow = foldHalf( LowSig, firstFoldFs, true );
LowSigHigh = foldHalf( LowSig, firstFoldFs, false);

% due to first stage downsample fliping effect. This two are actually
% fliped for frequency band. 
HighSigLow = foldHalf( HighSig, firstFoldFs, true );
HighSigHigh = foldHalf( HighSig, firstFoldFs, false);

figure(5) ; 
SpectrogramPlot(  LowSigLow , secondFoldFs);
title("0 - 2000 Hz signal  ");

figure(6) ; 
SpectrogramPlot(  LowSigHigh , secondFoldFs);
title("2000 - 4000 Hz signal  ");

figure(7) ; 
SpectrogramPlot(  HighSigLow , secondFoldFs);   
title("6000 - 8000 Hz signal (shoulud be 6-8K due to flip) ");

figure(8) ; 
SpectrogramPlot(  HighSigHigh , secondFoldFs);
title("4000 - 6000 Hz signal  (shoulud be 4-6K due to flip) ");


% restoring signals, example of up sampling.

uppedLLExample = UpIntSample(LowSigLow , 2);
figure(100) ; 
SpectrogramPlot(  uppedLLExample , secondFoldFs * 2);
title("up-sampling of 0-2k Hz data without Interpolation filter into 0-4K Hz ");


% restoring signals into 2 halfs.


recLowSide = foldDouble ( LowSigLow , secondFoldFs , true) + foldDouble ( LowSigHigh , secondFoldFs , false);
recLowSide = recLowSide *2 ; % restore the amplitude
figure (21)
SpectrogramPlot(recLowSide, secondFoldFs *2 );
title ("restored signal of 0-4000 Hz")

recHighSide = foldDouble ( HighSigLow , secondFoldFs , true) + foldDouble ( HighSigHigh , secondFoldFs , false);
recHighSide = recHighSide*2 ; % restore the amplitude
figure (22)
SpectrogramPlot(recHighSide, secondFoldFs *2 );
title ("restored signal of 4000-8000 Hz ")

% restoring signals back into one chunk
recSpeechData = foldDouble ( recLowSide , firstFoldFs , true) + foldDouble ( recHighSide , firstFoldFs , false);
recSpeechData = recSpeechData*2 ; % restore signal strength
figure (23)
SpectrogramPlot(recSpeechData, firstFoldFs *2 );
title ("restored signal of 0-8000 Hz ")



function   [downData] = foldHalf( sourceData, sourceFs, LowerHalfT )
    downFs = sourceFs/2;
%     LP or HP filter
    if (LowerHalfT == true ) 
        downData = FIRLowPass(sourceData ,sourceFs , downFs/2 - 1 , downFs/2+1);

    else
        downData = FIRHighPass(sourceData ,sourceFs , downFs/2 - 1 , downFs/2+1);
    end
    
%     downSample
    downData = downIntSample(downData,sourceFs/downFs); 
end

function [upData] = foldDouble (sourceData, sourceFs ,LowerHalfT)

    upFs = sourceFs*2;
   
    upData = UpIntSample(sourceData ,upFs / sourceFs); 


%     LP or HP filter
    if (LowerHalfT == true ) 
        upData = FIRLowPass(upData ,upFs , sourceFs/2 - 1 , sourceFs/2+1);

    else
        upData = FIRHighPass(upData ,upFs , sourceFs/2 - 1 , sourceFs/2+1);
    end
    
%     downSample
end 


% something that should work, but didn't 
% rec24Data = FIRBandPass(recData , fs , 1000 , 2000);
% rec24Data = downIntSample(rec24Data , fs/speechFs);
% rec24Data = downIntSample(rec24Data , speechFs / (speechFs/2) );
% rec24Data = downIntSample(rec24Data , (speechFs/2) / (speechFs/4)  );
% rec24Data = downIntSample(rec24Data , (speechFs/4) / (speechFs/8)  );
% 
% figure(3)
% SpectrogramPlot(  rec24Data , 2000)
% title("2000- 4000")
