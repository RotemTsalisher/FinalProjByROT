% peak filters

fs = 44100;
T = 1;
N = fs*T;
t = (0:N-1)*(1/fs);
fgrid = fs*(0:N-1)/N;
frequencies = [75, 600]';

fc = 500;
wc = 2*pi*fc;
Q_factor = 1.25;
V0 = 1.2;

b = [(1/wc)^2, (V0/Q_factor)/wc, 1];
a = [(1/wc)^2, (1/Q_factor)/wc, 1];

H = tf(b,a);
pzmap(H); grid on;