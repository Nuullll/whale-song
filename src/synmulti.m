% src/synmulti.m
y1 = chirp(0:1/fs:0.11, 5039, 0.11, 5469);
y2 = chirp(0.11:1/fs:0.28, 5469, 0.28, 5556);
y3 = chirp(0.28:1/fs:0.36, 5556, 0.36, 5082);
dB = 1e-2;           % -20dB
signal2 = dB * [y1,y2,y3];

y1 = chirp(0:1/fs:0.12, 7407, 0.12, 8183);
y2 = chirp(0.12:1/fs:0.27, 8183, 0.27, 8269);
y3 = chirp(0.27:1/fs:0.36, 8269, 0.36, 6977);
dB = 1e-2;           % -20dB
signal3 = dB * [y1,y2,y3];

y1 = chirp(0:1/fs:0.12, 10550, 0.12, 11030);
y2 = chirp(0.12:1/fs:0.27, 11030, 0.27, 10900);
y3 = chirp(0.27:1/fs:0.36, 10900, 0.36, 9044);
dB = 1e-2;           % -20dB
signal4 = dB * [y1,y2,y3];

size = min([length(signal1),length(signal2),length(signal3),length(signal4)]);

signal1 = signal1(1:size);  % cut
signal2 = signal2(1:size);
signal3 = signal3(1:size);
signal4 = signal4(1:size);
signal = signal1 + signal2 + signal3 + signal4;

[S,F,T,P] = spectrogram(signal, 1024, 500, 1024, fs);
surf(T,F,10*log10(P),'edgecolor','none');
view(0,90);
xlabel('t/s');
ylabel('f/Hz');
axis([0 0.37 0 1.5e4]);
title('¶à±äÆµÄ£Äâ');
