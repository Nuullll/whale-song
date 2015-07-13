size = 16500;
Y = original(1:size);
d = 165;    % length of each part
y = reshape(Y, d, size/d);  % y: d * size/d matrix
y = max(y);     % maximum of each column
x = linspace(0, max(t), size/d);   % linear interpolation

subplot(3,1,1); plot(t, original);
title('Ô­Éù'); xlabel('t/s'); axis([0 0.37 0 1]);
subplot(3,1,2); plot(x,y);
title('Ô­Éù°üÂç'); xlabel('t/s'); axis([0 0.37 0 1]);