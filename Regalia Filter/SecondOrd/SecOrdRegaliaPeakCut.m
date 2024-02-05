function [b_,a_] = SecOrdRegaliaPeakCut(fc,Gdb,fs,BW)
    wc = 2*pi*fc;
    wb = 2*pi*BW;
    Ts = (1/fs);
    v0 = 10^(Gdb/20);
    d = -cos(wc*Ts);
    alpha = (v0-tan((wb*Ts)/2))/(v0+tan((wb*Ts)/2));
    
    Ap_a = [alpha, d*(1+alpha),1];
    Ap_b = [1, d*(1+alpha),alpha];

    b_ = (1/2)*(Ap_a + Ap_b) + (v0/2)*(Ap_a - Ap_b);
    a_ = Ap_b;
end