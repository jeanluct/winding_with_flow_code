width = 5; aspectratio = 1/1.4;
f = figure('Units','inches','Position',[1 1 width aspectratio*width], ...
           'Resize','off');
beta = C/D;
correction = 1.781072417990198; %exp(eulergamma)
normalizer = beta/8*log(4*D*T/r0^2/correction)^2;
bins = (-3:.31:60)*normalizer;
[a,b] = histcounts(X,bins,'Normalization','pdf');
x = (b - 0*pi^2/16*beta)/normalizer;  % what is this shift?
P = a*normalizer; x = (x(1:end-1) + x(2:end))/2;

semilogy(x,P,'Linewidth',2);
hold on
xgrid=0:.01:50;
ygrid=1/sqrt(2*pi).*xgrid.^(-3/2).*exp(-1./(2*xgrid));
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
textx = 32;
texty = 0.5;
% This assumes that T is a power of 10.
T_str = ['10^{' num2str(floor(log10(T))) '}'];
text(textx,10^(texty - 2),sprintf(['$t = ' T_str '$'],T),txtattribcap{:});
% This assumes that dt is a power of 10.
if log10(dt)>=-4
    dt_str = sprintf('%g',dt);
else
    dt_str = ['10^{' num2str(floor(log10(dt))) '}'];
end
axis([-2,50,10^-4,10^.2]);
hold off

xlabel('$x$',txtattrib{:});
ylabel('pdf',txtattrib{:})
set(gca,txtattrib2{:});

% L2 error
x = x(1:end-3);
P = P(1:end-3);
P2 = real(1/sqrt(2*pi).*x.^(-3/2).*exp(-1./(2*x)));
error_L2 = sqrt(trapz(x,(P-P2).^2));
err_str = sprintf('$\\mathrm{error} = %.3g$',error_L2);
text(textx,10^(texty - 2.4),err_str,txtattribcap{:});
