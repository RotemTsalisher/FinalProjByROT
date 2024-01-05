function [b,a] = AuxiliaryCoeffsLP(fc, fs, N)
Ts = 1/fs;
wc = 2*pi*fc;
k = tan((wc*Ts)/2);

den = 1 + sqrt(2)*k + k^2;
b0 = (k^2)/den; b1 = (2*k^2)/den; b2 = (k^2)/den;
a0 = 1; a1 = 2*(k^2-1)/den; a2 = (1-sqrt(2)*k + k^2)/den;
a = [a0 a1 a2]; b = [b0 b1 b2];

%[H, fgrid] = freqz(b,a,N,fs); %filter coeffs are correct
%plot(fgrid, 20*log(abs(H))); grid on; axis([20, 2000, -20, 0]);

% hand made plot needs to be fixed, 
% need to have better understanding of the returning frequency vector 
% and the calculations needed in order to calculate the (almost) "continuous" 
% f-vector


% [H, wo] = freqz(b,a,N);
% fgrid = 2*atan(wo*fs/(pi)); 
% H_ = 20*log(abs(H));
% plot(fgrid,H_); grid on; axis([20 2000 -10 0]);

end