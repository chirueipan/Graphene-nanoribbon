a=2.46;
H=0;
B=0;
t=-2.7;
N=64;
kp=100;
k=linspace(-1,1,kp);

t1=2*cos(k*pi/2);
t2=ones(kp);
for i=1:kp;
%the neareast hopping of the edge
  H(1,2)=t1(i);
  H(N,N-1)=t1(i);
  for j=2:N-1;
  %the nearest hopping inside the ribbon 
    if (rem(j,2)==0);
       H(j,j-1)=t1(i);
       H(j,j+1)=t2(i);
    elseif (rem(j,2)==1);
       H(j,j-1)=t2(i);
       H(j,j+1)=t1(i);
    end;
  end;
  y=eig(H)*t;
  for m=1:N
    B(m,i)=y(m);
  end;
end;
for m=N/2-1:N/2
    axis([-1,1,0,3])
    subplot(4,1,1),plot(k,B(m,:));
  hold on;
end;
