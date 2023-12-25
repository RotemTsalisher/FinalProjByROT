% calculating coeffs of Z domain LP filter using auxilary variable K
fs = 44100;
fc = 100;
wc = 2*pi*fc;
T = 1;
duration = 1;
N = fs*duration;
t = (0:N-1)*(1/fs);
portion = 1000;
fgrid = fs*(0:N-1)/N;
x = sin(2*pi*75.*t) + sin(2*pi*660.*t);

k = tan(wc*(T/2)); % auxiliary variable k = tan(wc*T/2);

% H(z) coefficients in terms of auxiliary variable k:
a0 = k^2/(1 + sqrt(2)*k + k^2);
a1 = 2*k^2/(1 + sqrt(2)*k + k^2);
a2 = k^2/(1 + sqrt(2)*k + k^2);
a = [a0 a1 a2]; 

b0 = 1; b1 = 2*(k^2-1)/(1 + sqrt(2)*k + k^2); 
b2 = (1-sqrt(2)*k + k^2)/(1 + sqrt(2)*k + k^2);
b = [b0 b1 b2];

[H_z, theta] = freqz(b,a,N); % H(z)
f_ = (theta*fs)/(2*pi);
y = filter(b,a,x);

subplot(311); plot(t(1:portion),x(1:portion)); title("Original Signal"); xlabel("t[sec]"); ylabel("x(t)"); grid on;
subplot(312); plot(t(1:portion),y(1:portion)); title("Filtered Signal"); xlabel("t[sec]"); ylabel("y(t)"); grid on;
subplot(313); plot(f_,20*log(abs(H_z))); title("Filter"); xlabel("f[Hz]"); ylabel("|H(f)|"); grid on; xline(fc, ":");
