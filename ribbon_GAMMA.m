lattice_constant=2.46;
Hamiltonian=0;
Band_structure=0;
gamma0=-2.7;
%gamma_edge is a parameter whose value is 0~1
gamma_para_zz=[1];
gamma_perp_zz=[5];
number_of_basis=64;
number_of_kpoints=5000;
number_of_gamma=1;
k=linspace(-1,2,number_of_kpoints);


intractn_on_zz=2*cos(k*pi/2);
intractn_bt_zz=ones(number_of_kpoints);

for index_of_gamma=1:number_of_gamma;

for index_of_k=1:number_of_kpoints;
%the neareast hopping of the edge
  Hamiltonian(1,2)                                                   =gamma_para_zz(index_of_gamma)*intractn_on_zz(index_of_k);
  Hamiltonian(number_of_basis,number_of_basis-1)=gamma_para_zz(index_of_gamma)*conj(intractn_on_zz(index_of_k));
  for index_of_basis=2:number_of_basis-1;
  %the nearest hopping inside the ribbon 
     if (rem(index_of_basis,2)==0);
           Hamiltonian(index_of_basis,index_of_basis-1)=gamma_para_zz(index_of_gamma)*conj(intractn_on_zz(index_of_k));
           Hamiltonian(index_of_basis,index_of_basis+1)=gamma_perp_zz(index_of_gamma)*intractn_bt_zz(index_of_k);
     elseif (rem(index_of_basis,2)==1);
           Hamiltonian(index_of_basis,index_of_basis-1)=gamma_perp_zz(index_of_gamma)*intractn_bt_zz(index_of_k);
           Hamiltonian(index_of_basis,index_of_basis+1)=gamma_para_zz(index_of_gamma)*intractn_on_zz(index_of_k);
     end;
  end;
  y=eig(Hamiltonian)*gamma0;
  for index_of_subband=1:number_of_basis;
     Band_structure(index_of_subband,index_of_k)=y(index_of_subband);
  end;
end;


  for index_of_subband=number_of_basis/2-number_of_basis/4:number_of_basis/2+number_of_basis/4;
    axis([-1,2,-10,10])
    subplot(number_of_gamma,1,index_of_gamma),plot(k,Band_structure(index_of_subband,:));
    hold on;
  end;
x=linspace(-1,1);
subplot(number_of_gamma,1,index_of_gamma),plot(x,2);
end;



