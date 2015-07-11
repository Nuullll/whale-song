# 小白鲸找妈妈

郭一隆 2013011189

## 感受歌声

### 小白鲸原声

+ 生成代码:

  ```matlab
  original = wavread('whalesong.wav')
  fs = 44.1e3
  plot([0:1/fs:(length(original)-1)/fs],original),title('小白鲸原声')
  ```

+ 音频曲线:
![小白鲸原声](pic/OriginalWave.png)

+ 局部放大图:
![原声局部放大](pic/OriginalWaveZoomIn.png)
  - 从图像估算频率
  
    ```
    f = ((0.2006 - 0.1988) / 31) ^ -1 = 2.654 kHz
    ```
  
  - 频域分析

    ```matlab
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

+ 显然利用`FFT`得到的结果更靠谱, 利用`fe = 2.757 kHz`的单频信号模拟, 生成[single_f.wav](wav/single_f.wav)
  ```matlab
  single_f_wav = sin(2*pi*fe*t)
  wavwrite(single_f_wav, fs, 16, 'G:\projects\whale-song\wav\single_f.wav')
  ```
  - 整体波形
  ![单频整体](pic/SingleFrequency.png)

  - 局部放大
  ![单频局部](pic/SingleFrequencyZoomIn.png)

  然而, 这并没有什么卵用, 因为这个单频信号听起来就像被*打码*的语音... 脑洞如此大的笔者也想象不出这是白鲸的叫声

