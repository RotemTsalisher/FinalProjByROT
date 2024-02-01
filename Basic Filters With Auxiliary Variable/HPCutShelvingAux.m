function [b,a] = HPCutShelvingAux(fc,fs, Gdb)
    wc = 2*pi*fc;
    Ts = 1/fs;
    k = tan((wc*Ts)/2);
    v0 = 10^(Gdb/20);

    den_b = v0 + sqrt(2*v0)*k + k^2;
    den_a = 1 + sqrt(2/v0)*k + (k^2)/v0;
    b0 = (1 + sqrt(2)*k + k^2)/den_b;
    b1 = 2*((k^2)-1)/den_b;
    b2 = (1 - sqrt(2)*k + k^2)/den_b;
    a0 = 1;
    a1 = 2*(((k^2)/v0)-1)/den_a;
    a2 = (1-sqrt(2/v0)*k+(k^2)/v0)/den_a;

    a = [a0 a1 a2]; b = [b0 b1 b2];
end