# 小白鲸找妈妈

郭一隆 2013011189

## 单频模拟

### 小白鲸原声

+ 生成代码:

  ```matlab
  original = wavread('whalesong.wav')
  fs = 44.1e3
  plot([0:1/fs:(length(original)-1)/fs],original),title('小白鲸原声')
  ```

  *.wav默认采样率为44.1kHz*

+ 音频曲线:

  ![小白鲸原声](pic/OriginalWave.png)

  从图中可以直观地感受到频率很高, 这和我们听到的直观(音调高)是符合的.


+ 局部放大图:

  ![原声局部放大](pic/OriginalWaveZoomIn.png)

  - 从图像估算频率
  
    ```
    f = ((0.2006 - 0.1988) / 31) ^ -1 = 2.654 kHz
    ```
  
  - 频域分析

    ```matlab
    % src/fft_original.m
    fs = 44.1e3;            % sampling rate: 44.1kHz
    N = length(original);   % sample size
    n = 0:N-1;
    t = n / fs;             % time sequence
    f = n / N * fs;         % frequency sequence

    y = fft(original, N);
    plot(f, abs(y));
    title('频域分析');
    ```

    ![频域分析原声](pic/FFTOriginal.png)
  
    ```matlab
    [Y, I] = max(abs(y))
    fe = I / N * fs
    ```

    得`fe = 2.757 kHz`

+ 显然利用`FFT`得到的结果更靠谱, 利用`fe = 2.757 kHz`的单频信号模拟, 生成[synfixed.wav](wav/synfixed.wav)
  ```matlab
  single_f_wav = sin(2*pi*fe*t)
  wavwrite(single_f_wav, fs, 16, 'G:\projects\whale-song\wav\synfixed.wav')
  ```
  - 整体波形
    ![单频整体](pic/SingleFrequency.png)

  - 局部放大
    ![单频局部](pic/SingleFrequencyZoomIn.png)

  然而, 这并没有什么卵用, 因为这个单频信号听起来就像被*打码*的语音... 脑洞如此大的笔者也想象不出这是白鲸的叫声


## 变频模拟

+ 时频图
  
  ![时频图](pic/TFPlot.png)

  由时频图可以看出:

    - 白鲸歌声频域的能量主要集中在`2757Hz`左右

    - 还有少部分能量分布在其他频率段(单边带宽约为`15kHz`)

    - 频域能量分布随时间变化

    - 能量最集中的频段也有略微变化, `t < 0.06s`时主频率单调上升, `t > 0.30s`时主频率单调下降

  ![时频图取点](pic/TFPlotData.png)

    由上图估算:

    - `f(t=0) = 2412 Hz`

    - `f(t=0.06) = 2756 Hz`

    - `f(t=0.30) = 2756 Hz`

    - `f(t=0.37) = 2584 Hz`

+ 产生模拟信号

  - 频域: **分段折线逼近**

    ```matlab
    % src/single_f_estimate.m
    y1 = chirp(0:1/fs:0.06, 2412, 0.03, 2584);
    y2 = chirp(0.06:1/fs:0.30, 2756, 0.18, 2756);
    y3 = chirp(0.30:1/fs:0.37, 2756, 0.335, 2670);

    subplot(1,1,1);
    [S,F,T,P] = spectrogram([y1,y2,y3], 256, 250, 256, fs);
    surf(T,F,10*log10(P),'edgecolor','none');
    view(0,90);
    xlabel('t/s');
    ylabel('f/Hz');
    axis([0 0.37 0 1.5e4]);
    title('变频模拟');
    ```

    ![变频模拟](pic/Single.png)

    *注: 时频图上有少量其他频率分量, 可能是离散信号取点不精确造成的*

  - 时域: **原声包络**

    ```matlab
    % src/find_envelope.m
    size = 16500;
    Y = original(1:size);
    d = 165;    % length of each part
    y = reshape(Y, d, size/d);  % y: d * size/d matrix
    y = max(y);     % maximum of each column
    x = linspace(0, max(t), size/d);   % linear interpolation

    subplot(2,1,1); plot(t, original);
    title('原声'); xlabel('t/s'); axis([0 0.37 0 1]);
    subplot(2,1,2); plot(x,y);
    title('原声包络'); xlabel('t/s'); axis([0 0.37 0 1]);
    ```

    ![原声包络](pic/Envelope.png)

    **利用原声包络调制产生的变频信号**

    ```matlab
    % src/single_modulation.m
    mag = interp1(x,y,0:1/fs:16319/fs);   % run find_envelope.m first

    subplot(3,1,1); plot(t,original);
    axis([0 0.37 -1 1]); title('原声'); xlabel('t/s');

    subplot(3,1,2); plot(t(1:length(mag)),[y1,y2,y3]);   % run single_f_estimate.m first
    axis([0 0.37 -1 1]); title('变频模拟'); xlabel('t/s');

    subplot(3,1,3); plot(t(1:length(mag)),mag.*[y1,y2,y3]);    
    axis([0 0.37 -1 1]); title('变频模拟调幅'); xlabel('t/s');
    ```

    ![变频信号调制](pic/SingleModulation.png)

    ```matlab
    wavwrite(mag.*[y1,y2,y3],fs,16,'G:\projects\whale-song\wav\synsingle.wav')
    ```

    生成[synsingle.wav](wav/synsingle.wav), 这次模拟的信号已经和原声有些相似, 听得出声音强度的变化, 但音调仍然很单一, 而且声音不够饱满.