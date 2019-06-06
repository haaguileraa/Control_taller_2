% diseño del controlador para el levitador por el lugar de las raices

tao = 0.1;
K= 1;
p1 = 4.85;

%%
clc
clear 

s=tf('s');

Num_prac = 0.68975;
Den_prac = s*(s*s*0.01524+s*0.2732+1);

lev= Num_prac/Den_prac;


G = tf(lev);

% diseño del controlador
k=10;
z=-1;
p=5*z;
C = zpk([z],[p],k)
L1=C*G;
%C1=k;
%L2=C1*G;
T=feedback(L1,1);
plc=pole(T);
% plot de la region de diseno
delete(gcf)

figure(1)
rlocus(L1)


for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end

%% convirtiendo C a variables de estado

var=c2d(C,10^-3)

cdva=ss(var)



%% Graficando respuestas al escalon
tam_step =0.05; % m
volt=12;
U=(C*tam_step*volt)/(1+C*G)
figure(2)
step(U)
grid on


figure(3)
step(T)
%xlim([0 60]) 
grid on
% Para la tensión tenemos la función de sensibilidad

