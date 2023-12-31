% peak filters
% when designing an equalizing system for a signal, with the Q-factor,
% the equalizer's bandwidth of proccessed frequencies,
% (for a given center frequency fc) is in inverse relations with the Q-factor
% {i.e -> bigger Q factor means smaller processing bandwidth, and vice
% versa}.

% this basically means that in a zero-pole analysis, we expect to witness
% the distance between a pole and a neighboring zero INCREASE as the
% Q-factor gets smaller, and vice versa.

fs = 44100;
T = 1;
N = fs*T;
t = (0:N-1)*(1/fs);
fgrid = fs*(0:N-1)/N;
frequencies = [75, 600]';

fc = 500;
wc = 2*pi*fc;
Q_factor_1 = 1.25; fb1 = fc/Q_factor_1;
V0 = 1.2;

b1 = [(1/wc)^2, (V0/Q_factor_1)/wc, 1];
a1 = [(1/wc)^2, (1/Q_factor_1)/wc, 1];

Q_factor_2 = 0.707; fb2 = fc/Q_factor_2;

b2 = [(1/wc)^2, (V0/Q_factor_2)/wc, 1];
a2 = [(1/wc)^2, (1/Q_factor_2)/wc, 1];

H = tf(b,a);
%figure(1); pzmap(H); grid on;
fb1_str = ["Zero-Pole Plot (fc,Q,fb) = (" + num2str(fc) + "," + num2str(Q_factor_1) + "," + num2str(fb1) + ")"];
fb2_str = ["Zero-Pole Plot (fc,Q,fb) = (" + num2str(fc) + "," + num2str(Q_factor_2) + "," + num2str(fb2) + ")"];
figure(1); subplot(211); zplane(b1,a1); title(fb1_str); grid on;
subplot(212); zplane(b2,a2); title(fb2_str); grid on;