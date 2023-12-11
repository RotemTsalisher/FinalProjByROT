function octave_analysis()
    figure_counter = 1;
    c_major_freqs = [261.6 329.6 392];
    fs = 48000;
    T = 1;
    [x,t] = my_sawtooth(c_major_freqs,fs);
    [coeff_mat, freq_resp, fgrid] = octave_filters(27.5,fs);
    [n,m] = size(coeff_mat);
    for i = [1:2:n]
    figure(figure_counter); subplot(211);plot(t,x); grid on;
    y = filter(coeff_mat(i,:),coeff_mat(i+1,:),x);
    figure(figure_counter); subplot(212); plot(t,y); grid on;
    sound(y,fs);
    pause(1.1*T);
    end
end