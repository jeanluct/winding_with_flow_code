width = 5; aspectratio = 1/1.4;
f = figure('Units','inches','Position',[1 1 width aspectratio*width], ...
           'Resize','off');

correction = 1.781072417990198; %exp(eulergamma)
normalizer0 = 1/2*log(4*D*T/ra^2);
normalizer = 1/2*log(4*D*T/ra^2/correction);
bins = min(X):(.31*normalizer):max(X);
[a,b] = histcounts(X,bins,'Normalization','pdf');
x = b/normalizer; P = a*normalizer; x = (x(1:end-1) + x(2:end))/2;
x0 = b/normalizer0; P0 = a*normalizer0; x0 = (x0(1:end-1) + x0(2:end))/2;

semilogy(x0,P0,'m:','Linewidth',2);
hold on
semilogy(x,P,'Linewidth',2);
xgrid=-10:.01:10;
ygrid=1/2.*sech(xgrid.*pi./2);
semilogy(xgrid,ygrid,'r--','Linewidth',2);

fonttype = 'Times';
fsize = 14;
fcsize = 11;
lw = 2;
txtattrib2 = {'FontName',fonttype,'FontSize',fsize,'FontWeight','normal'};
txtattrib = {txtattrib2{:},'Interpreter','Latex'};
txtattribcap = {'FontName',fonttype,'FontSize',fcsize,'Interpreter','Latex'};

l = legend('G\&F','improved','$\frac12\mathrm{sech}(\pi x/2)$');
set(l,txtattribcap{:});
textx = -9.5;
texty = 2.2;
T_str = ['10^{' num2str(floor(log10(T))) '}'];
text(textx,10^(texty - 2),sprintf(['$t = ' T_str '$'],T),txtattribcap{:});
% This assumes that T is a power of 10.
if log10(dt)>=-4
    dt_str = sprintf('%g',dt);
else
    dt_str = ['10^{' num2str(floor(log10(dt))) '}'];
end
axis([-10,10,10^-4,10^.5]);
hold off

xlabel('$x$',txtattrib{:});
ylabel('pdf',txtattrib{:})
set(gca,txtattrib2{:});

% L2 error
P2 = 1/2*sech(x*pi/2);
error_L2 = sqrt(trapz(x,(P-P2).^2))
error_L20 = sqrt(trapz(x0,(P0-P2).^2))
err_str0 = sprintf('$\\mathrm{G\\&F\\ error} = %.3g$',error_L20);
text(textx,10^(texty - 2.3),err_str0,txtattribcap{:});
err_str = sprintf('$\\mathrm{improved\\ error} = %.3g$',error_L2);
text(textx,10^(texty - 2.6),err_str,txtattribcap{:});
