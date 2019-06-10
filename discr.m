%Discretización:
%% PI
%clear 
clc
%Se obtuvo:
 %6 (s+0.2)
 % ---------
 %  (s+0.1)
   
Cpi=zpk([-0.2], [-0.1], [6]);
Cpif = tf(bilin(ss(Cpi),1,'fwdrec',10^-3))  %Mejor cantidad de decimales