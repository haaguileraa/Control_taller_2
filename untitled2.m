clc
clear 

s=tf('s');

Num_prac = 0.68975;
Den_prac = s*(s*s*0.01524+s*0.2732+1);

lev= Num_prac/Den_prac;


G = tf(lev);

% diseno del controlador
k=13*2
z=-0
p=-10
C = zpk([z],[p],k)
%C=20;
L1=C*G;
T=feedback(L1,1)
plc=pole(T);

tam_step =0.05; % m
volt=12;
U=(C*tam_step)/(1+C*G);



% plot de la region de diseno
delete(gcf)

figure(1)
rlocus(L1)

for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end


figure(2)
step(U)
title('Time Response U')
grid on

figure(3)
step(T)
title('Time Response T')
grid on

var=c2d(C,10^-3)
Cpif = tf(bilin(ss(C),1,'fwdrec',10^-3))
cdva=ss(Cpif)
%cdvaa=ss(var)

S=1-T;
ep = dcgain(S);