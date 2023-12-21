% filtering an audio signal with various peak-filter systems, defined by
% varying V0 gains.
% the goal is to hear the impact on the output signal

clc; clf;
fs = 44100;
T = 1.25; 
N = T*fs; 
portion = 2000;
t = (0:N-1)*(1/fs);
fgrid = fs*(0:N-1)/N;

frequencies = [880, 1046.5, 1318.51, 1760]/2; % notes = [A5, C6, E6, A6]
x = sum(sin(2*pi*frequencies'.*t));
Xf_mag = abs((1/N)*fft(x,N));
counter = 1; %plot counter;
figure(counter); plot(fgrid,Xf_mag); grid on; xlabel("f[Hz]"); ylabel("Y(f)"); title("Original Signal Spectrum");
axis([20 2*10^3 0 0.6]); set(gca,'XTick', sort([frequencies,[200, 800,1000, 1800, 2000]])); counter = counter + 1;

Q = 15; % narrow band
fc = 1046.5/2; % processing is centered arround C6;
wc = 2*pi*fc;
V0_vec = [.5, .75, 1, 1.2, 1.5, 1.75, 2, 2.2, 2.5, 3];

sys_mat = [];
output_mat = [];

for V0 = V0_vec
    b = [(1/wc)^2, (V0/(Q*wc)), 1];
    a = [(1/wc)^2, (1/(Q*wc)), 1];
    [b_z, a_z] = bilinear(b,a,fs);
    if(V0 < 1)
        [a_z, b_z] = bilinear(a,b,fs);
    else
        [b_z, a_z] = bilinear(b,a,fs);
    end
    y = filter(b_z,a_z,x);
    sys_mat = [sys_mat; b_z; a_z];
    Yf_mag = abs((1/N)*fft(y,N));
    figure(counter);
    subplot(311); plot(t(1:portion), x(1:portion)); grid on; xlabel('t[sec]'); ylabel('x(t)'); title("Original Audio Signal x(t)"); axis tight;
    [H_, wout] = freqs(b,a); subplot(312); plot(wout/(2*pi),20*log(abs(H_))); title("Filter for V0 = " + num2str(V0) + ", Gain in [dB] = " + 20*log(V0)); grid on;
    xline(fc, 'blue:'); xlim([20 2*10^3]);
    subplot(313); plot(fgrid, Yf_mag, wout/(2*pi), abs(H_), 'black--'); grid on; xlabel("f[Hz]"); ylabel("Y(f)"); 
    axis([20 2*10^3 0 2.5]); set(gca,'XTick', sort([frequencies,[200, 800,1000, 1800, 2000]]));
    counter = counter +1;
    %sound(y,fs);
    %pause(1.5*T);
end