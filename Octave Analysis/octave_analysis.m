function octave_analysis()
    figure_counter = 1;
    c_major_freqs = [261.6 329.6 392];
    % c_major_freqs = 2*c_major_freqs; -> for testing purposes 
    fs = 48000; T = 1; N = fs*T;
    [x,t] = my_sawtooth(c_major_freqs,fs);
    [coeff_mat, freq_resp, fgrid] = octave_filters(27.5,fs);
    [n,m] = size(coeff_mat);
    for i = [1:2:n]
        figure(figure_counter); subplot(311);plot(t,x); grid on; title("Original Signal {\copyright} ROT"); xlabel("t[sec]");ylabel("x(t)");
        y = filter(coeff_mat(i,:),coeff_mat(i+1,:),x);
        %subplot(412); plot(fgrid,abs(freq_resp(figure_counter)),'black');
        subplot(312); plot(t,y); grid on; title("Filtered Sig - Time Domain"); ylabel("y(t)"); xlabel("t[sec]");
        subplot(313); plot(fgrid,abs(fft(y,N))); grid on; xlim([20,20*10^3]); title("Filtered Sig - Frequency Domain"); xlabel("f[Hz]"); ylabel("Y(f)");
        sound(y,fs);
        pause(1.1*T);
        figure_counter = figure_counter + 1;
    end
end