function [b,a] = peakWithAux(fc, Gdb, BW,fs)
    wc = 2*pi*fc;
    Ts = 1/fs;
    v0 = 10^(Gdb/20);
    k = tan(wc*Ts/2);
    Q = fc/BW;

    [b,a] = peakAuxBoost(fc,v0,Q,k);
end