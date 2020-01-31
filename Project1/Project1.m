clc
clear
% setup hardward
devices = audiodevinfo();
intputID = devices.input(1).ID;
outputID = devices.output(1).ID;

% global settings 
fs = 96000;    % Typical values supported by most sound cards are 8000, 11025, 22050, 44100, 48000, and 96000 hertz.
nBits = 24;
nChannel = 1;
recLength = 8; % seconds
recObj = audiorecorder(fs,nBits,nChannel); % leave ID blank as default

% the cell to hold all three recording
recDatas = {[],[],[];fs,fs,fs};

text = ["The quick brown fox jumps over the lazy dog",
        "We promptly judged antique ivory buckles for the next prize",
        "Crazy Fredrick bought many very exquisite opal jewels"];
%     file names from other team
filenames = [   "team8-soundfile-1.wav",
                "team8-soundfile-2.wav",
                "team8-soundfile-3.wav"];
    
% Ask for source of audio
fprintf("Select source of audio \n");
sourceType = input("=> 0 for record || 1 for audio file ");
sourceTypeText = "";

% Start Recording all three phrase
if (sourceType==0)
    fprintf("\n * record audio data\n");
    fprintf("Each clip will be %d seconds long\n",recLength);
    sourceTypeText = "recording";
    pause(1);
    
    for ii= 1:length(text)
    %     Recording
        fprintf("\n** part %d\n",ii)
        RecordPrompt(text(ii) );
        CountDown(2);
        Record(recObj,recLength);
    %     Playback 
        playerObj = getplayer(recObj);
        play(playerObj);

    %     Record and Display signal
        recArray = getaudiodata(recObj);
        simplePlot(recArray,ii)
        recDatas{1,ii}=recArray;
        audiowrite(sprintf("team8-soundfile-%d.wav",ii),recDatas{1,ii},fs);

    %     wait for playing to end
        simpleCountdown("playback remains",recLength);
        pause(0.5);
    end
end

if (sourceType ==1) 
    sourceTypeText = "audio file";
    fprintf("\n * read audio file \n");
    for ii = 1:length(filenames())
        fprintf("reading file %s \n",filenames(ii));
        [recDatas{1,ii} , recDatas{2,ii}] = audioread( filenames(ii) );
    end
end 

% plot spectrogram
fprintf("\n ---------- \n");
fprintf("generating spectrogram from %d audio sources of %s \n" , length(recDatas) , sourceTypeText);
for ii= 1:length(recDatas)
    figure(ii);
    SpectrogramPlot(recDatas{1,ii},recDatas{2,ii} )
    title( sprintf("Spectrogram of speech # %d from %s",ii,sourceTypeText) );
end

% generate stereo file
    fprintf("\ngenerate fake stero using audio clip 1\n\n");
    recArray = recDatas{1,1};
    recArray(:,2) = zeros(length(recArray),1);
    audiowrite(sprintf("team8-stereosoundfile.wav"),recArray,recDatas{2,1});
    
    disp("== Program Finished ==")
    
    
    
    
%
%
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  %
%
%
% simpleHelpers

function [] = simplePlot(recArray,index)
    figure(10+index)
    plot(recArray);
    xlabel("Time (s)")
    ylabel("Signal Strength")
    title( sprintf("Time plot of speech # %d ",index) );
end

function [] = simpleCountdown(text,length)
    for t=length : -1  :   0
       lineLength=fprintf('%s %d s',text, t);
       pause(1)
       fprintf(repmat('\b',1,lineLength))
    end
end

