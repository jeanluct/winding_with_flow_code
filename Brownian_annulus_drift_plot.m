width = 5; aspectratio = 1/1.4;
f = figure('Units','inches','Position',[1 1 width aspectratio*width], ...
           'Resize','off');
beta = C/D;
A = 2*D*T/(rb^2-ra^2)*log(rb/ra);
normalizer = sqrt(2*A);
bins = 100;
[a,b] = histcounts(X,bins,'Normalization','pdf');
x = (b-A*beta)/normalizer; P = a*normalizer; x = (x(1:end-1) + x(2:end))/2;

semilogy(x,P,'Linewidth',2);
hold on
xgrid = -4:.1:4;
ygrid = 1/sqrt(2*pi)*exp(-xgrid.^2/2);
semilogy(xgrid,ygrid,'r--','Linewidth',2);

fonttype = 'Times';
fsize = 16;
fcsize = 14;
lw = 2;
txtattrib2 = {'FontName',fonttype,'FontSize',fsize,'FontWeight','normal'};
txtattrib = {txtattrib2{:},'Interpreter','Latex'};
txtattribcap = {'FontName',fonttype,'FontSize',fcsize,'Interpreter','Latex'};

l = legend('data','Gaussian','Location','South');
set(l,txtattribcap{:});
textx = -1;
texty = -1.8;
% This assumes that T is a power of 10.
if log10(T) == 1
	T_str = '10';
else
	T_str = ['10^{' num2str(floor(log10(T))) '}'];
end
text(textx,10^(texty - .4),sprintf(['$t = ' T_str '$'],T),txtattribcap{:});
axis([-4,4,10^-4,10^0]);
hold off

xlabel('$x$',txtattrib{:});
ylabel('pdf',txtattrib{:});
set(gca,txtattrib2{:});
