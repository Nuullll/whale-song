% src/find_envelope.m
size = 16500;
Y = original(1:size);
d = 165;    % length of each part
y = reshape(Y, d, size/d);  % y: d * size/d matrix
y = max(y);     % maximum of each column
x = linspace(0, max(t), size/d);   % linear interpolation

subplot(1,1,1); plot(t, original);
title('ԭ��'); xlabel('t/s'); axis([0 0.37 0 1]);
hold on;
plot(x,y);
title('ԭ������'); xlabel('t/s'); axis([0 0.37 0 1]);