fs = 44100; N = 2^12; f0 = 440; f1 = 2765.25; T = N/fs;
t = (0:N-1)*(1/fs); f_ = fs*(0:N-1)/N;
x1 = sin(2*pi*f0.*t); x2 = sin(2*pi*f1.*t);

[X1_f,X2_f] = twoRealSigsDFT(x1,x2,N);
plot(f_,abs(X1_f/max(abs(X1_f))),f_,abs(X2_f)/max(abs(X1_f))); xlim([0,fs/10]); grid on;
xlabel("f[hz]"); ylabel("X1_f,X2_f"); title("Frequency Components of Signals x1(n),x2(n)", "Calculated using simultaneous DFTs");