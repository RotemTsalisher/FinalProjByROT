clc;
exp_ = exp(-j*((2*pi)/16).*[0:15]);
x = [1,1,1,0,1,1,1,0]
N_ = length(x);
X = forward_dft(x,N_,exp_)
x_ = (1/N_)*idft_using_dft(X,N_,exp_);
x_
save("exp_for_dft_16.csv","exp_")