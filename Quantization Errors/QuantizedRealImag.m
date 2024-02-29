m = 8;
M = 2^m;
real_pole = linspace(-1,1,M);
imag_pole = linspace(-1,1,M);
[rp_ ip_] = meshgrid(real_pole,imag_pole);

poles = [rp_(:) + 1i*ip_(:)];
poles(abs(poles)>1) = NaN;
scatter(real(poles),imag(poles),'.'); title(["Possible Poles Map", "Quantization of Re(Z_p), Im(Z_p) Values", [num2str(m) + " Bit Quantization"]]);
xlabel("Real(Z)"); ylabel("Imag(Z)");
axis([0 1 0 1]); grid on;