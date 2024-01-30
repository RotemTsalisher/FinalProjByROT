fs = 44100;
T = 1;
N = fs*T;
Ts = (1/fs);

t = (0:N-1)*Ts;
fgrid = fs*(0:N-1)/N;
frequencies = [440 880];

xt = sum(sin(2*pi.*[frequencies]'.*t)); Xf = (1/N)*fft(xt);
figure(1); subplot(221); plot(t(1:1000), xt(1:1000)); grid on; axis tight;
title("Original Sig"); xlabel("t[sec]"); ylabel("x(t)");
subplot(222); plot(fgrid, abs(Xf)); grid on; axis([20,1200, 0, 0.72]);
title("Original Sig Spectrum"); xlabel("f[Hz]"); ylabel("X(f)");

Gdb = 3;
fc = 440;
BW = 100;

[b,a] = peakWithAux(fc,Gdb,BW,fs);
y_ = filter(b,a,xt); yt = RelativeRMS(0,xt,y_); Yf = (1/N)*fft(yt);
subplot(223); plot(t(1:1000), yt(1:1000)); grid on; axis tight;
title("Filtered Sig"); xlabel("t[sec]"); ylabel("y(t)");
subplot(224); plot(fgrid,abs(Yf)); grid on; axis([20 1200 0 0.72]);
title("Filtered Sig Spectrum"); xlabel("f[Hz]"); ylabel("Y(f)");