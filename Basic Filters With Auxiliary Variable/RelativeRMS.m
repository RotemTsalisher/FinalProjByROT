function y_ = RelativeRMS(pdb,x,y)
    
    p = 10^(pdb/20);
    N = length(x);
    M = length(y);
    xSquaredSum = sum(x.^(2)); ySquaredSum = sum(y.^(2)); beta = (M/N)*p^2;
    alpha = sqrt(beta*xSquaredSum/ySquaredSum);

    y_ = alpha*y;
end