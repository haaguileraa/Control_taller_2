
%%
k= 4; %6;
%z1=-6+0.01*j
%z2=conj(z1)
z1=-3
z2=-0.4
p1=0;
p2=10*real(z2);

%%
clear 
clc

s=tf('s')

Num_prac = 0.68975;
Den_prac = s*(s*s*0.01524+s*0.2732+1);

lev= Num_prac/Den_prac;


G = tf(lev)

% diseño del controlador
k= 4; 
z1=-3;
z2=-0.4;
p1=0;
p2=10*real(z2);
p= [p1 p2]
%p = [p1];
z = [z1 z2];

C = zpk([z],[p],k)
L1=C*G;
T=feedback(L1,1)
plc=pole(T);

tam_step =  0.05; % m
volt=12;

U=(C*tam_step*volt)/(1+C*G);

% plot de la region de diseno
delete(gcf)
figure(1)
rlocus(L1)

for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end

%%
figure(2)
step(U)
title('Time Response U')
grid on


figure(3)
step(T)
title('Time Response T')
grid on

%var=c2d(C,10^-3)

%Gtu = tf(bilin(ss(C),1,'Tustin',10^-3))
%cdva=ss(Gtu)

%cdva=ss(var)
%% Discretización
[As,Bs,Cs,Ds] = tf2ss([0 0 0 0.68975], [0.01524 0.2732 1 0])
[Ad, Bd, Cd, Dd] = c2dm(As,Bs,Cs,Ds, 10^-3,'fwdrec')


%%
load('./datos/PID.mat')

figure(4)
step(T)
ylim([0 1.3])
legend('Step(T)')
hold all;
plot(t/1000,x1,'r','LineStyle','--')

