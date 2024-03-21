function [X1_f,X2_f] = twoRealSigsDFT(x1,x2,N)
    exp_ = readmatrix("exp_for_dft_2pow20.csv");
    z = x1 + j*x2;
    Z = forward_dft(z,N,exp_);
    
    X1_f = zeros(1,N);
    X2_f = zeros(1,N);
    for k=[0:length(Z)-1]
        X1_f(k+1) = 0.5*real( Z(k+1) + Z( mod(N-k,N) +1 ) ) + j*0.5*imag(Z(k+1) - Z( mod(N-k,N) +1 ) );
        X2_f(k+1) = 0.5*imag( Z(k+1) + Z( mod(N-k,N) +1 ) ) - j*0.5*real(Z(k+1) - Z( mod(N-k,N) +1 ) );
    end

end