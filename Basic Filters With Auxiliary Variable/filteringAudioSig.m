fs = 44100;
T = 1;
N = fs*T;
fc = 880;
f0 = 440; f1 = 1396.91;
t = (0:N-1)*(1/fs);
A0 = 2; A1 = 1.3;
fgrid = fs*(0:N-1)/N;
xt = A0*sawtooth(2*pi*f0.*t) + A1*sin(2*pi*f1.*t);
Xf = (1/N)*fft(xt);

%% LP Section: 

[b,a] = AuxiliaryCoeffsLP(fc,fs);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N, "Low Pass (With Auxiliary Variable)")


%% HP section: 

[b,a] = AuxiliaryCoeffsHP(fc,fs);
yt = filter(b,a,xt);
% Yf = (1/N)*fft(yt);
plotRes(xt,yt,t,fgrid,N,"High Pass (With Auxiliary Variable)")


%% BP section: 

[b,a] = AuxiliaryCoeffsBP(fc,fs,fc/4);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Band Pass (With Auxiliary Variable)")

%% shelving and peak filters
%% LP (SHELVING) BOOST:

[b,a] = LPBoostShelvingAux(fc*0.5,fs,0.85);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Low Pass Shelving (With Auxiliary Variable, Boost Mode)")

%% LP (SHELVING) CUT:

[b,a] = LPCutShelvingAux(fc*0.5,fs,0.9);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Low Pass Shelving (With Auxiliary Variable, Cut Mode)")

%% Peak Boost:

[b,a] = peakAuxBoost(fc*0.5,fs,0.9,sqrt(2)*(0.5)*fc);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Peak (With Auxiliary Variable, Boost Mode)")

%% Peak Cut:

[b,a] = peakAuxCut(fc*0.5,fs,0.9,sqrt(2)*(0.5)*fc);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Peak (With Auxiliary Variable, Cut Mode)")