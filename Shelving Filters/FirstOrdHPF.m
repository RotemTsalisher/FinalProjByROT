clc; clf;
fs = 44100;
T = 1;
N = fs*T;
t = (0:N-1)/fs;
portion = 1500;
freqs_ = [75 600];
x = sin(2*pi*freqs_(1).*t) + sin(2*pi*freqs_(2).*t); %freq components (75,660)[Hz]

figure(1); subplot(211); plot(t(1:portion),x(1:portion)); grid on; axis tight; xlabel("t[sec]"); ylabel("x(t)"); 
title_str = ["Demo Signal with freq components: (" + num2str(freqs_(1)) + "," + num2str(freqs_(2)) + ")[Hz]"];
title(title_str);

fgrid = fs*(0:N-1)/N;
X_f = (1/N)*fft(x,N);
mag_Xf = abs(X_f);
subplot(212); plot(fgrid,mag_Xf); grid on; axis([20, 20*10^3, 0, 1]); xlabel("f[Hz]"); ylabel("X(f)"); title("Spectrum of x");

% implement first ord hpf:
%           H0*s 
%  H(s) =  ----- => H(z) = {bilinear transform}
%          s + 1           

fc = 300;
H0 = 1;
b = [H0/(2*pi*fc) 0];
a = [1/(2*pi*fc) 1]; % s + 1
[b_z,a_z] = bilinear(b,a,fs)
y = filter(b_z,a_z,x);
Y_f = (1/N)*fft(y,N);
mag_Yf = abs(Y_f);
figure(2); subplot(211); plot(t(1:portion),y(1:portion)); grid on;axis tight; xlabel("t[sec]"); ylabel("y(t)"); title("Filtered Signal"); 
subplot(212); plot(fgrid,mag_Yf); grid on; axis([20, 20*10^3, 0, 0.6]); xlabel("f[Hz]"); ylabel("Y(f)"); title("Spectrum of y");

% LISTEN TO THE ORIGINAL AND FILTERED SIGNAL
% sound(x,fs);
% pause(1.2);
% sound(y,fs);