function plotRes(xt,yt,t,fgrid,N,filterName,fc)

Xf = (1/N)*fft(xt);
Yf = (1/N)*fft(yt);
yt_ = RelativeRMS(0,xt,yt);
Yf_ = (1/N)*fft(yt_);

figure(); 

subplot(321); plot(t(1:1000),xt(1:1000)); grid on; axis tight; 
title("Original Sig"); ylabel("x(t)"); xlabel("t[sec]");

subplot(322); plot(fgrid,abs(Xf)); grid on; axis([20,20000,0,max(abs(Xf)) + 0.05]);
title("Spectrum of Original Sig"); ylabel("X(f)"); xlabel("f[Hz]");

subplot(324); plot(fgrid,abs(Yf)); grid on; axis([20,20000,0,max(abs(Yf)) + 0.05]);
title("Spectrum of Filtered Sig"); ylabel("Y(f)"); xlabel("f[Hz]");

subplot(323); plot(t(1:1000),yt(1:1000)); grid on; axis tight; %axis([20,20000,0,1]);
title("Filtered Sig"); ylabel("x(t)"); xlabel("t[sec]");

subplot(325); plot(t(1:1000), yt_(1:1000)); grid on; axis tight;
title("Filtered Sig with Relative RMS"); ylabel("y'(t)"); xlabel("t[sec]");

subplot(326); plot(fgrid,abs(Yf_)); grid on; axis([20,20000,0,max(abs(Yf_)) + 0.05]);
title("Spectrum of Filtered Sig with Relative RMS"); ylabel("Y'(f)"); xlabel("f[Hz]");

sgtitle([("Filtering for " + filterName + " Filter:"), ("fc = " + fc  + "[hz]")])
end