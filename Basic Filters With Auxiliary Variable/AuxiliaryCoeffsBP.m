function [b,a] = AuxiliaryCoeffsBP(fc, fs,BW)
Ts = 1/fs;
wc = 2*pi*fc;
k = tan((wc*Ts)/2);
Q = fc/BW; alpha = 1/Q;

den = 1 + alpha*k + k^2;
b0 = alpha*k/den; b1 = 0; b2 = -alpha*k/den;
a0 = 1; a1 = 2*(k^2-1)/den; a2 = (1-alpha*k + k^2)/den;
a = [a0 a1 a2]; b = [b0 b1 b2];
end