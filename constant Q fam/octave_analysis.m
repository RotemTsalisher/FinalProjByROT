function octave_analysis()
    c_major_freqs = [261.6 329.6 392];
    fs = 48000;
    [x,t] = my_sawtooth(c_major_freqs,fs);
    [coeff_mat, freq_resp, fgrid] = constant_Q_fam(27.5,fs);
    figure(1); subplot(211);plot(t,x); grid on;
    y = filter(coeff_mat(9,:),coeff_mat(10,:),x);
    subplot(212); plot(t,y); grid on;
    sound(y,fs);
end