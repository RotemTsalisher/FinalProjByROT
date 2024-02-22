m = 8;
M = 2^m;
b1 = linspace(-2,2,M);
b2 = linspace(-1,1,M);
[b1_ b2_] = meshgrid(b1,b2);

poles = (1/2)*[-b1_(:) + sqrt(b1_(:).^2-4*b2_(:))];
poles(imag(poles)<=0) = NaN;
scatter(real(poles),imag(poles),'.'); title(["Possible Poles Map", "Second Order Direct Form IIR Filter", [num2str(m) + " Bit Quantization"]]);
xlabel("Real(Z)"); ylabel("Imag(Z)");
axis([0 1 0 1]); grid on;