function [b_,a_] = firstOrdRegaliaCut(fc,Gdb,fs)
    Ts = 1/fs;
    wc = 2*pi*fc;
    v0 = 10^(Gdb/20);

    k = (tan((wc*Ts)/2) - v0)/(tan((wc*Ts)/2)+v0);
    Ap_b = -1*[k,1]; Ap_a = [1,k];

    b_ = (1/2)*(Ap_a + Ap_b) + (v0/2)*(Ap_a - Ap_b);
    a_ = [1,k];
end