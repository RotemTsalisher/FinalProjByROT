fs = 44100;
fc = 440;
Gdb = 3;
T = 1;
N = fs*T;
fb = 100;


figure(1); [b,a] = SecOrdRegaliaPeakBoost(fc,Gdb,fs,fb);
[h_, f_] = freqz(b,a,N,fs);
h = 20*log(abs(h_));
y_ = max(abs(h))-2.88;
plot(f_(1:5000),h(1:5000)); grid on; xline(fc, "black:"); yline(y_,"black:");
xlabel("f [hz]"); ylabel("|H(z)| [dB]"); title("Regalia Filter, BP Peak Filter arround 440 [hz] in Boost Mode, with fb = 100 [hz]");
xticks(unique([get(gca,"XTick") 440])); yticks(unique([gca().YTick floor(y_)]));
text(fc + 1.1, 1.1,["fc = " + num2str(fc) + "[hz]"]); text(fc + 3*fb, y_ + .1, "|H(f)| = max(|H(f)|) -3[dB]");
ax_xlabels = get(gca,"XTickLabel"); ax_xlabels{2} = "fc = " + num2str(fc); xticklabels(ax_xlabels); xtickangle(45);
x = [fc-fb/2 fc+fb/2];
y = [y_ y_];
str1 = ['f_c_1 = ' num2str(fc-fb/2)];
str2 = ['f_c_2 = ' num2str(fc+fb/2)];
labels = {str1,str2};
hold on; plot(x,y,'b.',MarkerSize=22); hold off;
text(x(1)-1.5*fb,y(1),labels(1),'VerticalAlignment','bottom','HorizontalAlignment','left')
text(x(2)+1.5*fb,y(2),labels(2),'VerticalAlignment','bottom','HorizontalAlignment','right')

figure(2); [b,a] = SecOrdRegaliaPeakCut(fc,-Gdb,fs,fb);
[h_, f_] = freqz(b,a,N,fs);
h = 20*log(abs(h_));
y_ = -1*(max(abs(h))-2.88);
plot(f_(1:12500),h(1:12500)); grid on; xline(fc, "black:"); yline(y_,"black:");
xlabel("f [hz]"); ylabel("|H(z)| [dB]"); title("Regalia Filter, BP Peak Filter arround 440 [hz] in Cut Mode, with fb = 100 [hz]");
xticks(unique([get(gca,"XTick") 440])); yticks(unique([gca().YTick floor(y_)]));
text(fc + 1.1, 1.1,["fc = " + num2str(fc) + "[hz]"]); text(fc + 6*fb, y_ + .1, "|H(f)| = max(|H(f)|) -3[dB]");
ax_xlabels = get(gca,"XTickLabel"); ax_xlabels{2} = "fc = " + num2str(fc); xticklabels(ax_xlabels); xtickangle(45);
y = [y_ y_];
hold on; plot(x,y,'b.',MarkerSize=22); hold off;
text(x(1)-3.7*fb,y(1),labels(1),'VerticalAlignment','bottom','HorizontalAlignment','left')
text(x(2)+4*fb,y(2),labels(2),'VerticalAlignment','bottom','HorizontalAlignment','right')
