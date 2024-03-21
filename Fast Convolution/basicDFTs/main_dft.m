clc;
exp_ = readmatrix("exp_for_dft_2pow20.csv");
x = [1,1,1,0,1,1,1,0]
N_ = length(x);
X = forward_dft(x,N_,exp_)
x_ = (1/N_)*idft_using_dft(X,N_,exp_);
x_
