% src/multi_modulation.m
% first, run find_envelope.m and synmulti.m respectively
mag = interp1(x,y,0:1/fs:(size-1)/fs);

subplot(3,1,1); plot(t,original);
axis([0 0.37 -1 1]); title('原声'); xlabel('t/s');

subplot(3,1,2); plot(t(1:length(mag)),signal);
axis([0 0.37 -1 1]); title('多变频模拟(局部)'); xlabel('t/s');

subplot(3,1,3); plot(t(1:length(mag)),mag.*signal);    
axis([0 0.37 -1 1]); title('多变频模拟调幅'); xlabel('t/s');

wavwrite(mag.*signal,fs,16,'G:\projects\whale-song\wav\synmulti.wav');
