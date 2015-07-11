# 小白鲸找妈妈

郭一隆 2013011189

## 感受歌声

### 小白鲸原声

```m
original = wavread('whalesong.wav')
sample_rate = 44.1e3
plot([0:1/sample_rate:(length(original)-1)/sample_rate],original),title('小白鲸原声')
```

![小白鲸原声](pic/OriginalWave.png)

