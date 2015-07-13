% src/t_f_plot.m
[S,F,T,P] = spectrogram(original, 1024, 500, 1024, fs);
surf(T,F,10*log10(P),'edgecolor','none');
view(0,90);
xlabel('t/s');
ylabel('f/Hz');
axis([0 0.37 0 1.5e4]);
title('ԭ��ʱƵͼ');