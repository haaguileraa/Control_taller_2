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
k=1
z=-1
p=10*z
C = zpk([z],[p],k);
L1=C*G;
T=feedback(L1,1);
plc=pole(T)


% plot de la region de diseno
delete(gcf)
rlocus(L1)

h = gca()
xscale = get(h,'xlim');
yscale = get(h,'ylim');


for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end

figure(2)
step(T)

