fs = 44100;
fc = 440;
Gdb = 3;
T = 1;
N = fs*T;


[b,a] = firstOrdRegaliaBoost(fc,Gdb,fs);
[h_, f_] = freqz(b,a,N,fs);
h = 20*log(abs(h_));
y_ = max(abs(h))-2.88;
plot(f_(1:5000),h(1:5000)); grid on; xline(fc, "black:"); yline(y_,"black:");
xlabel("f [hz]"); ylabel("|H(z)| [dB]"); title("Regalia Filter, LP Shelving Filter arround 440 [hz] in Boost Mode");
xticks(unique([gca().XTick 440])); yticks(unique([gca().YTick floor(y_)]));