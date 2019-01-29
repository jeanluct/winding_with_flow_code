width = 5; aspectratio = 1/1.4;
f = figure('Units','inches','Position',[1 1 width aspectratio*width], ...
           'Resize','off');
beta = C/D;
rat = ra * double(exp(eulergamma));
normalizer = beta/4*(log(4*D*T/rat^2))^2;
bins = (-1:.051:4)*normalizer;
[a,b] = histcounts(X,bins,'Normalization','pdf');
x = b/normalizer; P = a*normalizer; x = (x(1:end-1) + x(2:end))/2;

semilogy(x,P,'Linewidth',2);
hold on
xgrid = -.1:.051:5;
ygrid = EllipticThetaDistribution(xgrid,0);

semilogy(xgrid,ygrid,'r--','Linewidth',2);

fonttype = 'Times';
fsize = 16;
fcsize = 14;
lw = 2;
txtattrib2 = {'FontName',fonttype,'FontSize',fsize,'FontWeight','normal'};
txtattrib = {txtattrib2{:},'Interpreter','Latex'};
txtattribcap = {'FontName',fonttype,'FontSize',fcsize,'Interpreter','Latex'};

l = legend('data','$p_X(x)$');
set(l,txtattribcap{:});
textx = .3;
texty = -1;
% This assumes that T is a power of 10.
T_str = ['10^{' num2str(floor(log10(T))) '}'];
text(textx,10^(texty - .4),sprintf(['$t = ' T_str '$'],T),txtattribcap{:});
axis([-1,3,10^-3,10^.5]);
hold off

xlabel('$x$',txtattrib{:});
ylabel('pdf',txtattrib{:});
set(gca,txtattrib2{:})

P2 = EllipticThetaDistribution(x,0);
P2(isnan(P2)) = 0;
error_L2 = sqrt(trapz(x,(P-P2).^2));

err_str = sprintf('$\\mathrm{error} = %.3g$',error_L2);
text(textx,10^(texty - .7),err_str,txtattribcap{:});
