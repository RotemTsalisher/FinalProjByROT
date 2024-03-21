clear;clc;
x1 = [1,0,-1,0,1,0,-1,0,-1,0,1,0,1,0,-1,0]; x2 = [-1,0,1,0,1,0,-1,0,1,0,-1,0,1,0,-1,0]; N = 16;
for i=[1:2]
    x1 = [x1 x2];
    x2 = [x2 x2];
    N = 2*N;
end
[X1,X2] = twoRealSigsDFT(x1,x2,N);
X1_ = fft(x1);
X2_ = fft(x2);
if(and((X1-X1_ < 10^-6),(X2-X2_ < 10^-6)))
    disp("SUCCESS 1");
else
    disp("FAILURE!")
    X1-X1_
end