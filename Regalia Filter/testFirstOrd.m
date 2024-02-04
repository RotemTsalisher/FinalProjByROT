fs = 44100;
fc = 440;
Gdb = 3;
T = 1;
N = fs*T;


figure(1); [b,a] = firstOrdRegaliaBoost(fc,Gdb,fs);
[h_, f_] = freqz(b,a,N,fs);
h = 20*log(abs(h_));
y_ = max(abs(h))-2.88;
plot(f_(1:12500),h(1:12500)); grid on; xline(fc, "black:"); yline(y_,"black:");
xlabel("f [hz]"); ylabel("|H(z)| [dB]"); title("Regalia Filter, LP Shelving Filter arround 440 [hz] in Boost Mode");
xticks(unique([get(gca,"XTick") 440])); yticks(unique([gca().YTick floor(y_)]));
text(fc + 1.1, 1.1,["fc = " + num2str(fc) + "[hz]"]); text(fc + 1.1, y_ + .1, "|H(f)| = max(|H(f)|) -3[dB]");
ax_xlabels = get(gca,"XTickLabel"); ax_xlabels{2} = "fc = " + num2str(fc); xticklabels(ax_xlabels); xtickangle(45);

figure(2); [b,a] = firstOrdRegaliaCut(fc,-Gdb,fs);
[h_, f_] = freqz(b,a,N,fs);
h = 20*log(abs(h_));
y_ = -1*(max(abs(h))-2.88);
plot(f_(1:12500),h(1:12500)); grid on; xline(fc, "black:"); yline(y_,"black:");
xlabel("f [hz]"); ylabel("|H(z)| [dB]"); title("Regalia Filter, LP Shelving Filter arround 440 [hz] in Cut Mode");
xticks(unique([get(gca,"XTick") 440])); yticks(unique([gca().YTick floor(y_)]));
text(fc + 1.1, 1.1,["fc = " + num2str(fc) + "[hz]"]); text(fc + 1.1, y_ + .1, "|H(f)| = max(|H(f)|) -3[dB]");
ax_xlabels = get(gca,"XTickLabel"); ax_xlabels{2} = "fc = " + num2str(fc); xticklabels(ax_xlabels); xtickangle(45);

