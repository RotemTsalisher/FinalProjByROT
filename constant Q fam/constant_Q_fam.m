fs = 48000;                                                     % sampeling freq
f_bottom = 20;                                                  % bottom of spec
f_top    = 20*10^3;                                             % top of spec
fc = 27.5;                                                      % the frequency corresponding to musical note A0;
fc_vec = [fc];        
Q = 1/((2)^(1/2));                                              % butterworth quality factor;
for i = [1:10]                                                  % building series of frequencies fc_vec, where fc_i = 2*(fc_i-1)
    if(2*fc_vec(i) < f_top)                                                            
        fc_vec = [fc_vec 2*fc_vec(i)];                          % calculate a vector of fc frequencies, starting from A0  
    else                                                        % and seperated by an octave.
        break;        
    end        
end        
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
for i = [1:length(fc_vec)]                                      %                                         h1: b01 | b02 | b03... etc. 
    [b,a] = butter(2,[f_high(i), f_low(i)]./fs,"bandpass");
    coeff_mat = [coeff_mat;b;a];                                % add vectors b,a to the coeff matrix
    [h,~] = freqz(b,a,fs);                                      % calc frequency response of filter
    freq_resp_filt_mat = [freq_resp_filt_mat;h];                % add frequency resp vector to the filter matrix
    plot(fgrid,abs(h),'black');
end
xline(fc_vec,':'); yline(0.707, ':');                           % mark center frequencies and -3db 
xlabel("f[Hz] {\copyright}ROT"); ylabel("|H(f)|"); hold off; grid on;
title("Constast-Q Band Pass Filters"); axis([0,2*10^4,0,1]);