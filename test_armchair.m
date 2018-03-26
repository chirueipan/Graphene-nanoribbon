N=53;
p=linspace(1,N,N);
k=linspace(-2,2,1001);
for m=1:N
  B=-2.7*sqrt(1+4*cos(p(m)*pi/(N+1))*cos(p(m)*pi/(N+1))+4*cos(p(m)*pi/(N+1))*cos(k*pi/2));
  plot(k,B,k,-B);
  hold on;
end;
