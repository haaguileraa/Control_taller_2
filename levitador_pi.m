% diseño del controlador para el levitador por el lugar de las raices
% definimos las matrices de estado
tao = 0.1
K= 1
p1 = 4.85

A = [0 1 0; 0 -p1 p1; 0 0 -1/tao]
B = [0 0 K/tao]'
C = [1 0 0]

lev = ss(A,B,C,0)
G = tf(lev)

%%

clc
clear 

s=tf('s');

Num_prac = 0.68975;
Den_prac = s*(s*s*0.01524+s*0.2732+1);

lev= Num_prac/Den_prac;


G = tf(lev);

% diseno del controlador
k=7;
z=-0.2;
%p=-0.1
p=0;
C = zpk([z],[p],k)
%C=20;
L1=C*G;
T=feedback(L1,1)
plc=pole(T);

tam_step =0.05; % m
volt=12;
U=(C*tam_step*volt)/(1+C*G);



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
%error
S=1-T;
ep = dcgain(S)

%% Discretización
[As,Bs,Cs,Ds] = tf2ss([0 0 0 0.68975], [0.01524 0.2732 1 0])
[Ad, Bd, Cd, Dd] = c2dm(As,Bs,Cs,Ds, 10^-3,'fwdrec')

load('./datos/PI.mat')

figure(4)
step(T)
legend('Step(T)')
hold all;
plot(t/1000,x1,'r','LineStyle','--')

