function [b_,a_] = firstOrdRegaliaBoost(fc,Gdb,fs)
    Ts = 1/fs;
    wc = 2*pi*fc;
    v0 = 10^(Gdb/20);

    k = (tan((wc*Ts)/2) - 1)/(tan((wc*Ts)/2)+1);
    % b = (1/2)*[(1 + v0 + k*(v0-1)), ((k-1) + v0*(k+1))]; a = [1, k];
    % above are manual calcs, just as an experiment
    Ap_b = -1*[k,1]; Ap_a = [1,k];

    b_ = (1/2)*(Ap_a + Ap_b) + (v0/2)*(Ap_a - Ap_b);
    a_ = [1,k];
end

