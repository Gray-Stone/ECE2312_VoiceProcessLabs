clear 
clc 

filename = "audioclip-1581903146-7894.wav";
[recData, fs] = audioread( filename );
recLength = length(recData);


% generate time intervals. 
n = 1:1:recLength; 
n=n/fs;
n=transpose(n);

% generate sine tone
sinFeq = 5000 ; % Hz 
sinTone = sin(2 * pi * sinFeq * n);
% reduce amplitude to reduce ear pearcing
sinTone = sinTone/10; 

figure(1)
SpectrogramPlot(sinTone,fs)
title("Spectrogram of sine tone at 5000Hz")
% playing the sine tone is un plesent, it is avoided.
% sound(recData,fs);
audiowrite("team8-sinetone.wav",sinTone,fs);


% generate chirp tone
maxChirpFeq = 8000 ; % Hz
% generate chrip Feq scale at every sample point. 
chirpFeq = 1:1:recLength ;
chirpFeq = chirpFeq/(recLength/8000);
chirpFeq = transpose(chirpFeq);
chirpTone = zeros(recLength,1);
% generate through forloops to avoide matrix
for ii = 1:recLength
    chirpTone(ii,1) = sin(2 * pi * chirpFeq(ii,1) * n(ii,1) );
end
chirpTone = chirpTone/10;

figure(2)
SpectrogramPlot(chirpTone,fs)
title("Spectrogram of Chrip linear from 0 to 8000Hz")
% sound(chirpTone,fs);
audiowrite("team8-chirp.wav",chirpTone,fs);


% generate CETK
CETK = sinToneGen(392,1,fs);

tempCETK = sinToneGen(440,1,fs);
CETK(length(CETK)+1 : length(CETK)+length(tempCETK) ,1 ) = tempCETK ;

tempCETK = sinToneGen(349,1,fs);
CETK(length(CETK)+1 : length(CETK)+length(tempCETK) ,1 ) = tempCETK ;

tempCETK = sinToneGen(174,1,fs);
CETK(length(CETK)+1 : length(CETK)+length(tempCETK) ,1 ) = tempCETK ;

tempCETK = sinToneGen(261,1,fs);
CETK(length(CETK)+1 : length(CETK)+length(tempCETK) ,1 ) = tempCETK ;

CETK = CETK/10;

figure(3)
SpectrogramPlot(CETK,fs)
ylim([0 1000])
title("Spectrogram of CETK")
% sound(CETK,fs);
audiowrite("team8-cetk.wav",CETK,fs);




% add the tone to recording
recSine = sinTone + recData ;
figure(4)
SpectrogramPlot(recSine,fs)
title("Spectrogram of speech + sine tone at 5000Hz")
% sound(recSine,fs);
audiowrite("team8-speechsine.wav",recSine,fs);

% add the tone to recording
recChirp = chirpTone + recData ;
figure(5)
SpectrogramPlot(recChirp,fs)
title("Spectrogram of speech + chirp from 0 to 8000Hz")
% sound(recChirp,fs);
audiowrite("team8-speechchirp.wav",recChirp,fs);


% Filtering
FlpPB = 4000 ; % Hz
FlpSB = 4100 ; %Hz
F=[ 0 FlpPB   FlpSB fs/2] ; % frequency up to nyquist frequency
F = F/(fs/2) ; % normalize to 1

A=[1 1 0 0];
N = 1000 ; % order
b = firls(N,F,A);
recSineFiltered = filter(b,1,recSine);

figure(6)
SpectrogramPlot(recSineFiltered,fs)
title("Spectrogram of speech + sine tone filtered at 4000Hz low pass")
% sound(recSineFiltered,fs);
audiowrite("team8-filteredspeechsine.wav",recSineFiltered,fs);


%  Filtering chirp
recChirpFiltered = filter(b,1,recChirp);

figure(7)
SpectrogramPlot(recChirpFiltered,fs)
title("Spectrogram of speech + chrip filtered at 4000Hz low pass")
% sound(recChirpFiltered,fs);
audiowrite("team8-filteredspeechchirp.wav",recChirpFiltered,fs);


% stereo audio 
recStereo = recData ;
recStereo(:,2) = recSine ;

% reuse plot 1 and plot 4

% sound(recStereo,fs);
audiowrite("team8-stereospeechsine.wav",recStereo,fs);

