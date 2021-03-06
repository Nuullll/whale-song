% src/single_modulation.m
mag = interp1(x,y,0:1/fs:16319/fs);   % run find_envelope.m first

subplot(3,1,1); plot(t,original);
axis([0 0.37 -1 1]); title('原声'); xlabel('t/s');

subplot(3,1,2); plot(t(1:length(mag)),signal1);   % run single_f_estimate.m first
axis([0 0.37 -1 1]); title('变频模拟(局部)'); xlabel('t/s');

subplot(3,1,3); plot(t(1:length(mag)),mag.*signal1);    
axis([0 0.37 -1 1]); title('变频模拟调幅'); xlabel('t/s');

wavwrite(mag.*signal1,fs,16,'G:\projects\whale-song\wav\test.wav');