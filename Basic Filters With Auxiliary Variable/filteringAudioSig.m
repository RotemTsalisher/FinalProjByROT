
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
plotRes(xt,yt,t,fgrid,N, "Low Pass (With Auxiliary Variable)",fc)


%% HP section: 

[b,a] = AuxiliaryCoeffsHP(fc,fs);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"High Pass (With Auxiliary Variable)",fc)


%% BP section: 

[b,a] = AuxiliaryCoeffsBP(fc,fs,fc/4);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Band Pass (With Auxiliary Variable)",fc)

%% shelving and peak filters
%% LP (SHELVING) BOOST:

[b,a] = LPBoostShelvingAux(fc*0.5,fs,1.25);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Low Pass Shelving (With Auxiliary Variable, Boost Mode)",fc*0.5)
%% LP (SHELVING) CUT:

[b,a] = LPCutShelvingAux(fc*0.5,fs,3);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Low Pass Shelving (With Auxiliary Variable, Cut Mode)",fc*0.5)
%% HP (SHELVING) BOOST:

[b,a] = HPBoostShelvingAux(fc,fs,3);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"High Pass Shelving (With Auxiliary Variable, Boost Mode", fc);

%% HP (SHELVING) CUT:

[b,a] = HPCutShelvingAux(fc,fs,3);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"High Pass Shelving (With Auxiliary Variable, Cut Mode", fc);

%% Peak Boost:

[b,a] = peakAuxBoost(fc,fs,3,0.1*fc);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Peak (With Auxiliary Variable, Boost Mode)",fc)

%% Peak Cut:

[b,a] = peakAuxCut(fc*0.5,fs,3,0.1*fc);
yt = filter(b,a,xt);
plotRes(xt,yt,t,fgrid,N,"Peak (With Auxiliary Variable, Cut Mode)",fc*0.5)