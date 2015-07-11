original = wavread('G:\Vone\Tsinghua\2015spring\信号与系统\893404634_1_Project2015\Project2015\whalesong.wav');

fs = 44.1e3;            % sampling rate: 44.1kHz
N = length(original);   % sample size
n = 0:N-1;
t = n / fs;             % time sequence
f = n / N * fs;         % frequence sequence

y = fft(original, N);
plot(f, abs(y));
title('频域分析');
