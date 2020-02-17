function [] = SpectrogramPlot(recData,fs)
%SPECTROGRAMPLOT 
%   

window = hamming(512);
nOverlap = 256;
nFft = 1024;
[S,F,T,P] = spectrogram(recData,window , nOverlap , nFft , fs ,'yaxis');
% figure
surf(T,F,10*log10(P),'edgecolor','none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim',[-80,-20]);
ylim([0 8000]);
xlabel('Time (s)');ylabel('Frequency (Hz)');

end

