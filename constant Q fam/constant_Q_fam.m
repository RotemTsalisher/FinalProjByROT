function [coeff_mat,freq_resp_filt_mat,fgrid] = constant_Q_fam(f0,fs) 
if(nargin == 0)                                                 
    fs = 48000;                                                 % function sets fs = 48kHz as default value (in case wasn't passed)
    fc = 27.5;                                                  % function sets fc = 27.5 (the frequency corresponding to musical note A0) if wasn't passed
elseif(nargin == 1)                                                 
    fs = 48000;                                                 % sampeling freq
    fc = f0;                                                    % fc0
else
    fc = f0;
end   

f_bottom = 20;                                                  % bottom of spec
f_top    = 20*10^3;                                             % top of spec                                                          
Q = 1/((2)^(1/2));                                              % butterworth quality factor;
fc_vec = fc*2.^[0:9];                                           % building series of frequencies fc_vec, where fc_i = 2*(fc_i-1)      
fb = fc_vec./Q;                                                 % vector of each octave's bandwidth
f_low = fc_vec - fb/2;                                          % low -3db freqs
f_high = fc_vec + fb/2;                                         % high -3db freqs
N = fs;                                                         % number of evaluation points
        
        
%%%%% listen to the series fc_vec %%%%%        
% T = 1;        
% t= [0:1/fs:T];        
% for freq=  fc_vec        
%    sound(sin(2*pi*freq.*t),fs);        
%    pause(T);        
% end        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
            
freq_resp_filt_mat = [];                                        % a matrix to hold frequency response of each filter
coeff_mat = [];                                                 % a matrix to hold each filter's coeffs:  h0: b00 | b10 | b20...
clf; figure(1);                                                 %                                             ----------------
fgrid = fs*(0:(N-1))/(N);                                       %                                             a00 | a10 | a20...
hold on;                                                        %                                             ----------------
xlabel("f[Hz] {\copyright}ROT"); ylabel("|H(f)|"); grid on;     %                                         h1: b01 | b11 | b21... 
title("Constast-Q Band Pass Filters"); axis([0,2*10^4,0,1]);    %                                             a01 | a11 | a21...etc.
for i = [1:length(fc_vec)]                                      
    % DO NOT IMPELEMENT SYSTEMS WITH ALIASING:                 
    if(f_high(i)/fs < 0 || f_high(i)/fs > 1 || f_low(i)/fs < 0 || f_low(i)/fs > 1)                         
        break                                                                                                
    end
    [b,a] = butter(2,[f_high(i), f_low(i)]./fs,"bandpass");
    coeff_mat = [coeff_mat;b;a];                                % add vectors b,a to the coeff matrix
    [h,~] = freqz(b,a,fs);                                      % calc frequency response of filter
    freq_resp_filt_mat = [freq_resp_filt_mat;h'];               % add frequency resp vector to the filter matrix
    plot(fgrid,abs(h),'black');
end
xline(fc_vec,':'); yline(0.707, ':');                           % mark center frequencies and -3db 
hold off;
end