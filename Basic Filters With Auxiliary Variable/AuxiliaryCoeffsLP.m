function [b,a] = AuxiliaryCoeffsLP(fc, fs)
Ts = 1/fs;
wc = 2*pi*fc;
k = tan((wc*Ts)/2);

den = 1 + sqrt(2)*k + k^2;
b0 = (k^2)/den; b1 = (2*k^2)/den; b2 = (k^2)/den;
a0 = 1; a1 = 2*(k^2-1)/den; a2 = (1-sqrt(2)*k + k^2)/den;
a = [a0 a1 a2]; b = [b0 b1 b2];
end