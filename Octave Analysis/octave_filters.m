function [coeff_mat,freq_resp_filt_mat,fgrid] = octave_filters(f0,fs) 
% ALMOST IDENTICAL TO A CONST Q FAM SYSTEM
% THIS SYSTEM IS IMPLEMENTING A MATRIX OF OCTAVE FILTERS
% A FUNCTION TO BE CALLED FROM "octave_analysis.m", to analyze all spectrun
% pieces around center frequency f0 and it's octaves.
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
fc_vec = fc*2.^[0:9];        
Q = 1/((2)^(1/2));                                              % butterworth quality factor;       
N = fs;                                                         % number of evaluation points
freq_resp_filt_mat = [];                                        % a matrix to hold frequency response of each filter
coeff_mat = [];                                                 % a matrix to hold each filter's coeffs:  h0: b00 | b10 | b20...
clf; figure(1);                                                 %                                             ----------------
fgrid = fs*(0:(N-1))/(N);                                       %                                             a00 | a10 | a20...
hold on;                                                        %                                             ----------------
xlabel("f[Hz] {\copyright}ROT"); ylabel("|H(f)|"); grid on;     %                                         h1: b01 | b11 | b21... 
title("Octave-spread Butterworth Band Pass Filters"); axis([f_bottom,f_top,0,1]);    %                        a01 | a11 | a21...etc.
for i = [1:length(fc_vec)] 
    % DO NOT IMPELEMENT SYSTEMS WITH ALIASING:                 
    if(fc_vec(i)*Q/fs < 0 || fc_vec(i)*Q/fs > 1 || fc_vec(i)/(fs*Q) < 0 || fc_vec(i)/(fs*Q) > 1)                         
        break                                                                                                
    end
    [b,a] = butter(2,[fc_vec(i)/Q, fc_vec(i)*Q]./fs,"bandpass");
    coeff_mat = [coeff_mat;b;a];                                % add vectors b,a to the coeff matrix
    [h,~] = freqz(b,a,fs);                                      % calc frequency response of filter
    freq_resp_filt_mat = [freq_resp_filt_mat;h'];               % add frequency resp vector to the filter matrix
    plot(fgrid,abs(h),'black');
end
xline(fc_vec,':'); yline(0.707, ':');                           % mark center frequencies and -3db 
hold off;
end