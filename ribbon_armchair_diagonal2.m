lattice_constant=2.46;
Hamiltonian=0;
Band_structure=0;
gamma0=-2.7;
%gamma_edge is a parameter whose value is 0~1
%gamma_edge=[1];
number_of_basis=18;
number_of_kpoints=101;
%number_of_gamma=1;
k=linspace(-1,1,number_of_kpoints);


intractn_on_ladder=exp(j*k*pi/6);
intractn_bt_ladder=exp(j*k*pi/3);



for index_of_k=1:number_of_kpoints;
%the neareast hopping of the edge
  Hamiltonian(1,2)=intractn_on_ladder(index_of_k);
  Hamiltonian(number_of_basis/2+1,number_of_basis/2+2)=conj(intractn_on_ladder(index_of_k));
  if (rem(number_of_basis/2,2)==0);
    Hamiltonian(number_of_basis/2,number_of_basis/2-1)=conj(intractn_on_ladder(index_of_k));
    Hamiltonian(number_of_basis,number_of_basis-1)=intractn_on_ladder(index_of_k);
  end;
  if (rem(number_of_basis/2,2)==1);
    Hamiltonian(number_of_basis/2,number_of_basis/2-1)=intractn_on_ladder(index_of_k);
    Hamiltonian(number_of_basis,number_of_basis-1)=conj(intractn_on_ladder(index_of_k));
  end;
  
  
  
  for index_of_basis=2:number_of_basis/2-1;
  %the nearest hopping inside the ribbon 
    if (rem(index_of_basis,2)==0);
      Hamiltonian(index_of_basis,index_of_basis-1)=conj(intractn_on_ladder(index_of_k));
      Hamiltonian(index_of_basis,index_of_basis+1)=conj(intractn_on_ladder(index_of_k));
    end;
    if (rem(index_of_basis,2)==1);
      Hamiltonian(index_of_basis,index_of_basis-1)=intractn_on_ladder(index_of_k);
      Hamiltonian(index_of_basis,index_of_basis+1)=intractn_on_ladder(index_of_k);
    end;
  end;
  
  
  
  for index_of_basis=number_of_basis/2+2:number_of_basis-1;
  %the nearest hopping inside the ribbon
    if (rem(number_of_basis/2,2)==1);
      if (rem(index_of_basis,2)==0);
        Hamiltonian(index_of_basis,index_of_basis-1)=conj(intractn_on_ladder(index_of_k));
        Hamiltonian(index_of_basis,index_of_basis+1)=conj(intractn_on_ladder(index_of_k));
      end;
      if (rem(index_of_basis,2)==1);
        Hamiltonian(index_of_basis,index_of_basis-1)=intractn_on_ladder(index_of_k);
        Hamiltonian(index_of_basis,index_of_basis+1)=intractn_on_ladder(index_of_k);
      end;
    end;
    if (rem(number_of_basis/2,2)==0);     
      if (rem(index_of_basis,2)==0);
        Hamiltonian(index_of_basis,index_of_basis-1)=intractn_on_ladder(index_of_k);
        Hamiltonian(index_of_basis,index_of_basis+1)=intractn_on_ladder(index_of_k);
      end;
      if (rem(index_of_basis,2)==1);
        Hamiltonian(index_of_basis,index_of_basis-1)=conj(intractn_on_ladder(index_of_k));
        Hamiltonian(index_of_basis,index_of_basis+1)=conj(intractn_on_ladder(index_of_k));
      end;
    end;     
  end;
  
  
  
  
  for index_of_basis=1:number_of_basis/2;
      if (rem(index_of_basis,2)==1);
        Hamiltonian(index_of_basis,index_of_basis+number_of_basis/2)=conj(intractn_bt_ladder(index_of_k));
        Hamiltonian(index_of_basis+number_of_basis/2,index_of_basis)=intractn_bt_ladder(index_of_k);
      end;
      if (rem(index_of_basis,2)==0);
        Hamiltonian(index_of_basis,index_of_basis+number_of_basis/2)=intractn_bt_ladder(index_of_k);
        Hamiltonian(index_of_basis+number_of_basis/2,index_of_basis)=conj(intractn_bt_ladder(index_of_k));
      end;
  end;
  y=eig(Hamiltonian)*gamma0;
  for index_of_subband=1:number_of_basis;
    Band_structure(index_of_subband,index_of_k)=y(index_of_subband);
  end;
end;



for index_of_subband=1:number_of_basis;
  axis([-1,1,-10,10])
  subplot(number_of_gamma,1,index_of_gamma),plot(k,Band_structure(index_of_subband,:));
  hold on;
end;
%x=linspace(-1,1);
%subplot(number_of_gamma,1,index_of_gamma),plot(x,2);




