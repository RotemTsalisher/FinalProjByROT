function [b,a] = LPShelvingBetaCut(fc,Gdb,fs)
    v0 = 10^(Gdb/20);
    Ts = 1/fs;
    wc = 2*pi*fc;
    k = tan((wc*Ts)/2);
    alpha = (k-v0)/(k+v0);

    H0 = v0-1;
    b0 = 1 + (1+alpha)*H0/2; b1 = alpha + (1+alpha)*H0/2;
    b = [b0,b1];
    a0 = 1; a1 = alpha;
    a = [a0,a1];
end