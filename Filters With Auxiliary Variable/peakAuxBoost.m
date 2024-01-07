function [b,a] = peakAuxBoost(fc, v0, Q, k)
    den = (1 + (1/Q)*k + k^2);
    
    b0 = (1 + (v0/Q)*k + k^2)/den;
    b1 = 2*(k^2-1)/den;
    b2 = (1 - (v0/Q)*k + k^2)/den;
    a0 = 1;
    a1 = 2*(k^2-1)/den;
    a2 = (1 - (1/Q)*k + k^2)/den;

    b = [b0 b1 b2]; a = [a0 a1 a2];
end