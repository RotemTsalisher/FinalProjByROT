% implementation of a BP shelving filter, designed with the Q factor,
% centering around fc = 1000 Hz
% the goal is to show Q factor's affect on the system

clc,clf;
fs = 44100;
T = 1;
N = T*fs;
t = (0:N-1)*fs;
fgrid = fs*(0:N-1)/N;

fc = 1000;
wc = 2*pi*fc;
V0 = 2.2;
Q_vec = [.707 1.25 2.5 3 5];
sys_mat = [];

hold on;
for Q = Q_vec
    b = [(1/wc)^2 (V0/(Q*wc)) 1];
    a = [(1/wc)^2 (1/(Q*wc)) 1];
    [H_, wout] = freqs(b,a);
    sys_mat = [sys_mat; b; a;];
    H_mag = 20*log(abs(H_));
    semilogx(wout, H_mag,'black');
end
xlabel("w[rad/sec] {\copyright}ROT"); ylabel("|H(w)| [dB]"); title("Peak Filter centered arround wc = 2{\pi}1000, with varying Q-factor");
yline(20*log(V0),'blue--'); xline(2*pi*fc, "blue--"); set(gca, 'XTick', sort([wc, get(gca, 'XTick')])); grid on; hold off;
text(23000,5,"Q = .707"); text(14000,2,"Q = 2.5"); text(24000,20*log(V0)-.25,["Gain = " + num2str(20*log(V0)) + "[dB]"]);