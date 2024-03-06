m = 8;
M = 2^m;
k1 = linspace(-2.5,2.5,M);
k2 = linspace(-2.5,2.5,M);
[k1_,k2_] = meshgrid(k1,k2);

b1 = -(2-k1_(:).*k2_(:)-k1_(:).^3);
b2 = 1-k1_(:).*k2_(:);

poles = [-b1./2 + 1i*sqrt(b2-(b1.^2)/4)];
th = linspace(0,2*pi,length(2*poles-1));
poles(abs(poles)>1) = NaN;
poles(imag(poles)<10^(-3)) = NaN;
poles = [poles; conj(poles)];
scatter(real(poles),imag(poles),'.'); title(["Possible Poles Map", "Non Linear Relations", [num2str(m) + " Bit Quantization"]]);
xlabel("Real(Z)"); ylabel("Imag(Z)");
grid on; axis equal; hold on; plot(cos(th),sin(th),"black-.");