function plot_path(domaintype)

if nargin < 1, domaintype = 'point'; end

D = 1;

switch domaintype
  case 'point'
    beta = 1;
    T = 12;
    a = 0;
    b = 0;
    x0 = 1; y0 = 0;
    bndchk = @(R) true;
    rng(3)
  case 'inner_disk'
    beta = 3;
    T = 10;
    a = .5;
    b = 0;
    x0 = 1; y0 = 0;
    bndchk = @(R) (R > a);
    rng('default')
  case 'annulus'
    beta = 1;
    T = 5;
    a = .5;
    b = 2;
    x0 = 1; y0 = 0;
    bndchk = @(R) (R > a && R < b);
    rng('default')
  otherwise
    error('Unknown domain.')
end

dtmax = .001;
dt = dtmax;
maxsteps = 1000000;

ngood = 0;
nbad = 0;

t = zeros(maxsteps,1);
xv = zeros(maxsteps,1); yv = zeros(maxsteps,1);

xv(1) = x0; yv(1) = y0;

i = 2;

tic
while true
  Omega = beta/hypot(xv(i-1),yv(i-1))^2;
  x1 = xv(i-1) - yv(i-1)*Omega*dt + sqrt(2*D*dt)*randn(1);
  y1 = yv(i-1) + xv(i-1)*Omega*dt + sqrt(2*D*dt)*randn(1);
  R1 = hypot(x1,y1);

  if bndchk(R1)
    % Ok good, we haven't entered the wall.
    t(i) = t(i-1) + dt; xv(i) = x1; yv(i) = y1;
    % Let's try making the step size larger, but not too large.
    dt = min(1.2*dt,dtmax);
    ngood = ngood + 1;
    if t(i) >= T, break; end
    i = i + 1;
  else
    % Oops, we're in the wall.  Shrink the time step and try again.
    dt = .75*dt;
    nbad = nbad + 1;
  end
end
toc

fprintf('ngood = %d  nbad = %d  (%g %%)\n',ngood,nbad,100*nbad/(ngood+nbad));

t = t(1:i); xv = xv(1:i); yv = yv(1:i);

figure(1)
plot(xv,yv,'k-')
hold on
axis equal
set(gca,'XAxisLocation','origin','YAxisLocation','origin')

if a == 0
  plot(0,0,'r.','MarkerSize',10)
  set(gca,'XTick',[],'XTickLabel',[])
  set(gca,'YTick',[],'YTickLabel',[])
else
  th = linspace(0,2*pi,100);
  plot(a*cos(th),a*sin(th),'r-','LineWidth',2)
  set(gca,'XTick',[],'XTickLabel',[])
  set(gca,'YTick',[],'YTickLabel',[])
end

if b == 0
  XYmax = 1.05*max(abs([xv;yv]));
else
  th = linspace(0,2*pi,100);
  plot(b*cos(th),b*sin(th),'r-','LineWidth',2)
  XYmax = 1.05*b;
end

axis([-XYmax XYmax -XYmax XYmax])

hold off

print('-dpdf',['path_' domaintype])
