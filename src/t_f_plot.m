[S,F,T,P] = spectrogram(original,256,250,256,fs);

surf(T,F,10*log10(P),'edgecolor','none');
view(0,90);
xlabel('t/s');
ylabel('f/Hz');
