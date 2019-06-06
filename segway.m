%Donde Theta_ref = 0
clear 
clc
s = tf('s');
m1 = 2;
g=9.8;
m2 = 3.5;
I1 = 0.32;
I2 = 0.0065;
L = 0.4;
r = 0.061;
a = m2*g*L;
H1 = (m1+m2)*r*r + I1;
H3 = m2*L*L + I2;
D = 0.01168;
G = ( -H1 + H3 )/( D*s*s -a*H1 )

%% diseño del controlador
%% adelanto
k=900;
z=-50;
p=1.5*z;
C = zpk([z],[p],k)
L1=C*G;

%C1=k;
%L2=C1*G;
%% PID
%k= 1000000; 
%z1=-300;
%z2=-400;
%p1=0;
%p2=10*real(z1);
k= 100000; 
z1=-100;
z2=-200;
p1=0;
p2=20*real(z1);
p= [p1 p2]
%p = [p1];
z = [z1 z2];

C = zpk([z],[p],k)
L1=C*G;
T=feedback(L1,1)
plc=pole(T);


T=feedback(L1,1);
plc=pole(T);
% plot de la region de diseno
delete(gcf)

figure(1)
rlocus(L1)


for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end

figure(2)
step(T)
%xlim([0 60]) 
grid on

%% Respuesta a perturbacion
GP1 = G/(1+C*G);
figure(5)
step(5*GP1);
title('Respuesta a perturbación de 5°')

%%
figure(6)
impulse(5*T);
title('Respuesta a perturbación de 5°')


