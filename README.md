# 小白鲸找妈妈

郭一隆 2013011189

## 感受歌声

### 小白鲸原声

+ 生成代码:

```m
original = wavread('whalesong.wav')
sample_rate = 44.1e3
plot([0:1/sample_rate:(length(original)-1)/sample_rate],original),title('小白鲸原声')
```

+ 音频曲线:

![小白鲸原声](pic/OriginalWave.png)

+ 局部放大图:

![原声局部放大](pic/OriginalWaveZoomIn.png)
- 从图像估算频率

    f = ((0.2006 - 0.1988) / 10) ^ -1 = 5.556 kHz

- 