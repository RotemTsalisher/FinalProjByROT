function X = forward_dft(x,N,exp_)
   X = zeros(1,N);
   w0 = 16/N;
   
   for k = [0:N-1]
       X(k+1) = X(k+1) + sum(x.*exp_(w0*(mod(k*[0:N-1],N))+1));
   end

end