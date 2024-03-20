function X = idft_using_dft(x,N,exp_)
    x_ = j*conj(x);
    X = forward_dft(x_,N,exp_);
    X = j*conj(X);
end