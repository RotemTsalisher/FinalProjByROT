% second order HP shelving filter
fs = 44100;
T = 1;
N = T*fs;
t = (0:N-1)*(1/fs);
fgrid = fs*(0:N-1)/N;
n_plot = 1000;

frequencies = [75 600]';
x = sum(sin(2*pi*frequencies.*t));
Xf = (1/N)*fft(x,N);
Xf_mag = abs(Xf);

subplot(411);plot(t(1:n_plot),x(1:n_plot)); grid on; title("Original signal x(t)"); xlabel('t[sec]'); ylabel('x(t)'); axis tight;
subplot(412);plot(fgrid,Xf_mag); grid on; title("Original Signal Spectrum"); xlabel("f[Hz]"); ylabel("X(f)"); axis([20 20*10^3 0 1]);

H0 = 1.2;
V0 = 1 + H0;

fc = 500;
wc = 2*pi*fc;
b = [V0*(1/(wc))^2, ((2*V0)^(1/2))/wc , 1];
a = [(1/(wc))^2, (2^(1/2))/wc, 1];

if(V0 >= 1)
    [b_z, a_z] = bilinear(b,a,fs);
else
    [a_z, b_z] = bilinear(a,b,fs);
end

freqz(b_z,a_z,N)