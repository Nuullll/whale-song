y1 = chirp(0:1/fs:0.06, 2412, 0.06, 2756);
y2 = chirp(0.06:1/fs:0.30, 2756, 0.30, 2756);
y3 = chirp(0.30:1/fs:0.37, 2756, 0.37, 2584);
signal1 = [y1,y2,y3];

subplot(1,1,1);
[S,F,T,P] = spectrogram(signal1, 1024, 500, 1024, fs);
surf(T,F,10*log10(P),'edgecolor','none');
view(0,90);
xlabel('t/s');
ylabel('f/Hz');
axis([0 0.37 0 1.5e4]);
title('±äÆµÄ£Äâ');
