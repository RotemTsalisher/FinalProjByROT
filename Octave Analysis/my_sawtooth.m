function [my_saw,t] = my_sawtooth(freq,fs)
    if(nargin == 0)
        fs = 48000;                             % default sampeling freq
        freq = [261.6 329.6 392];               % default chord: c major
    elseif(nargin == 1)
        fs = 48000;
    end
    if(fs<2*max(freq))
        disp("ERROR: my_sawtooth return an empty value")
        disp("fs doesn't follow nyquist");
        return
    end
    T = 1;                                      % 1 sec sound signal
    t = [0:1/fs:T - 1/fs];                      % time grid
    my_saw_func =@(f0) sawtooth(2*pi*f0*t);     % anonymous func to calculate sawtooth
    my_saw = 0;
    for f_i = freq
        my_saw = my_saw + my_saw_func(f_i);     % calculate signal
    end
    sound(my_saw,fs);
    pause(1.2*T);

    % plot signal:
    N = fs*T;
    saw_f = fft(my_saw,N);
    sawtooth_f_mag = 20*log(abs(saw_f));
    sawtooth_f_mag = sawtooth_f_mag - max(sawtooth_f_mag);
    fgrid = fs*(0:(N-1))/(N);
    figure(1);
    semilogx(fgrid,sawtooth_f_mag); grid on; axis([20, 20*10^3 -100 0]);
    title("Sawtooth signal Spectrum:"); xlabel("f[Hz]{\copyright} ROT"); ylabel("X(f)");
end