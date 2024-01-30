function [b,a] = LPBoostShelvingAux(fc,fs, Gdb)
    wc = 2*pi*fc;
    Ts = 1/fs;
    k = tan((wc*Ts)/2);
    v0 = 10^(Gdb/20);

    den = 1 + sqrt(k) + k^2;
    a0 = (1 + sqrt(2*v0)*k + v0*k^2)/den;
    a1 = 2*(v0*(k^2)-1)/den;
    a2 = (1 - sqrt(2*v0)*k + v0*k^2)/den;
    b0 = 1;
    b1 = 2*(k^2-1)/den;
    b2 = (1-sqrt(2)*k+k^2)/den;

    a = [a0 a1 a2]; b = [b0 b1 b2];
end