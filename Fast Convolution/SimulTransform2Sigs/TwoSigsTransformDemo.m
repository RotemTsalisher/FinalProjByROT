clc;
exp_ = readmatrix("exp_for_dft_2pow20.csv");
x1 = [1,1,1,1,1,1,1,1];
x2 = [0,1,2,3,4,3,2,1];
X1 = fft(x1)
X2 = fft(x2)

z = x1 + j*x2;
N = 8;

Z = forward_dft(z,N,exp_);
X1_f = zeros(1,N);
for k=[0:length(Z)-1]
    X1_f(k+1) = 0.5*real( Z(k+1) + Z( mod(N-k,N) +1 ) ) + j*0.5*imag(Z(k+1) - Z( mod(N-k,N) +1 ) );
    X2_f(k+1) = 0.5*imag( Z(k+1) + Z( mod(N-k,N) +1 ) ) - j*0.5*real(Z(k+1) - Z( mod(N-k,N) +1 ) );
end
X1_f
X2_f