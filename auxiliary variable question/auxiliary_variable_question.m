% comparing results:
% designing H(z) as a lp filter with fc = 100 hz
% first design is with the use of an auxiliary variable
% according to the formulas provided in Udo Zoler's book,
% formulas are implemented here for a0,a1,a2,b0,b1,b2 and added in a
% seperate pdf

% second implementation is a straight forward design of the second order
% filter in S domain, and then the 'bilinear' function is mapping poles and
% zeros to Z domain.

% FIRST FILTER DIVERGES, the 'a' coeff vector calculations are visibly incorrect (after
% comparing to the second filter, which is working correctly and filtering
% correctly

v0 = 2;
fs = 44100;
duration = 1;
N = fs*duration;
t = (0:N-1)*(1/fs);
fc = 1000;
wc = 2*pi*fc;
T = 1;

a = [(1/wc)^2 (sqrt(2*v0))/wc v0]; % s domain coeffs
b = [(1/wc)^2 sqrt(2)/wc 1];

[b_z, a_z] = bilinear(b,a,fs); %mapping to z domain

k = tan(wc*T/2); den = (1 + sqrt(2)*k + k^2);
% implementation of formulas given in the book
a0 = k^2/den; a1 = (2*k^2)/den; a2 = k^2/den;
b0 = 1; b1 = 2*(k^2-1)/den; b2 = (1-sqrt(2)*k + k^2)/den;

coeff_seq = [a0 a1 a2 b0 b1 b2];
coeff_names = {'a0'; 'a1'; 'a2'; 'b0'; 'b1'; 'b2'};
x_axis = categorical(coeff_names);
figure(1);
subplot(211);stem(x_axis,coeff_seq); grid on; title("Coeff Series According to Udo Zoler Formulas (using auxiliary variable k)"); 
subplot(212);stem(x_axis,[a_z b_z], 'black--'); grid on; title("Designed in S domain and used 'bilinear' function to transform coeffs");
figure(2); freqz(b_z,a_z,N);
figure(3); freqz([b0 b1 b2], [a0 a1 a2], N);