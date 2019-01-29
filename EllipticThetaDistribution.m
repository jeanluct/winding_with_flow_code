function val = EllipticThetaDistribution(x,mu)
val = zeros(size(x));

x_big = find(x>0.001);
val_big = zeros(size(x_big));

M = 100;

for i = 0:M
    val_big = val_big + (-1)^i.*(i+1/2).*exp(-(i+1/2).^2.*pi^2.*(x(x_big)+mu));
end

val(x_big) = val_big;
val = val*pi*2;

end