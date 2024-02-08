clf;
fs = 44100;
Ts = 1/fs;
fc_LP = [20,50,100,1000]; fc_HP = [1,3,5,10,16]*10^3;
fc_BP = [50,100,1000,3000,10000]; BW = 100;
Gdb = 18;
T = 1;
N = T*fs;

figure(1);
for fc = fc_LP 
    [b1,a1] = LPShelvingBetaBoost(fc,Gdb,fs);
    [b2,a2] = LPShelvingBetaCut(fc,-Gdb,fs);

    [h1,f1] = freqz(b1,a1,N,fs);
    [h2,f2] = freqz(b2,a2,N,fs);
    semilogx(f1,20*log10(abs(h1)),"black",f2,20*log10(abs(h2)),"black"); grid on;
    hold on;
end
hold off; xlim([20, 20000]); ylim([-20,20]); xticks([20,200,2000,20000]); xlabel("f [Hz]"); ylabel("|H(f)| [dB]"); 
title("First Order Low Pass Shelving Filter {by ROT}", "(G = +/- 18 [dB]; fc = [20,50,100,1000] [Hz])");


figure(2);
for fc = fc_HP
    [b3,a3] = HPShelvingBetaBoost(fc,Gdb,fs);
    [b4,a4] = HPShelvingBetaCut(fc,-Gdb,fs);

    [h3,f3] = freqz(b3,a3,N,fs);
    [h4,f4] = freqz(b4,a4,N,fs);
    semilogx(f3,20*log10(abs(h3)),"black",f4,20*log10(abs(h4)),"black"); grid on;
    hold on;
end
hold off; xlim([20, 20000]); ylim([-20,20]); xticks([20,200,2000,20000]); xlabel("f [Hz]"); ylabel("|H(f)| [dB]"); 
title("First Order Low Pass Shelving Filter {by ROT}", "(G = +/- 18 [dB]; fc = [1,3,5,10,16] [kHz])");

figure(3);
for fc = fc_BP
    [b5,a5] = PeakBetaBoost(fc,Gdb,fs,BW);
    [b6,a6] = PeakBetaCut(fc,-Gdb,fs,BW);

    [h5,f5] = freqz(b5,a5,N,fs);
    [h6,f6] = freqz(b6,a6,N,fs);
    semilogx(f5,20*log10(abs(h5)),"black",f6,20*log10(abs(h6)),"black"); grid on;
    hold on;
end
hold off; xlim([20, 20000]); ylim([-20,20]); xticks([20,200,2000,20000]); xlabel("f [Hz]"); ylabel("|H(f)| [dB]"); 
title("Secong Order Peak Filter {by ROT}","(G = +/- 18 [dB]; fc = [50,100,1000,3000,10000] [kHz], BW = 100 [Hz])");

