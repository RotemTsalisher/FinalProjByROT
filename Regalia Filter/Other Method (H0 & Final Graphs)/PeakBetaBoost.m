function [b,a] = PeakBetaBoost(fc,Gdb,fs,BW)
    
    v0 = 10^(Gdb/20);
    Ts = 1/fs;
    wc = 2*pi*fc; theta_c = wc*Ts; wb = 2*pi*BW;
    k = tan((wb*Ts)/2); d = -cos(theta_c);
    alpha = (k-1)/(k+1);

    H0 = v0-1;
    b0 = 1 + (1+alpha)*H0/2; b1 = d*(1-alpha); b2 = (-alpha -(1+alpha)*(H0/2));
    b = [b0,b1,b2];
    a0 = 1; a1 = d*(1-alpha); a2 = -alpha;
    a = [a0,a1,a2];
end