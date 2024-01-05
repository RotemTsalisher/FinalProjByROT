fs = 44100;
T = 1;
N = fs*T;
fc = 1000;
f0 = 440; f1 = 523.3;
t = (0:N-1)*(1/fs);
A0 = 2; A1 = 1.3;
fgrid = fs*(0:N-1)/N;
xt = A0*sawtooth(2*pi*f0.*t) + A1*sin(2*pi*f1.*t);
Xf = (1/N)*fft(xt);
figure(1); subplot(221); plot(t(1:1000),xt(1:1000)); grid on; axis tight; 
title("Original Sig"); ylabel("x(t)"); xlabel("t[sec]");
subplot(222); plot(fgrid,abs(Xf)); grid on; axis([20,20000,0,0.65]);
title("Spectrum of Original Sig"); ylabel("X(f)"); xlabel("f[Hz]");

[b,a] = AuxiliaryCoeffs(fc,fs,N);
yt = filter(b,a,xt);
Yf = (1/N)*fft(yt);

subplot(224); plot(fgrid,abs(Yf)); grid on; axis([20,20000,0,0.65]);
title("Spectrum of Filtered Sig"); ylabel("Y(f)"); xlabel("f[Hz]");
subplot(223); plot(t(1:1000),yt(1:1000)); grid on; axis tight; %axis([20,20000,0,1]);
title("Filtered Sig"); ylabel("x(t)"); xlabel("t[sec]");
sound(xt,fs); pause(T*1.5); sound(yt,fs);

%[H_, wo] = freqz(b,a,N);
%subplot(313); plot(wo*fs/(2*pi), 20*log(abs(H_))); grid on; axis([20,2000, -10,0]);