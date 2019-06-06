
pkg load control
graphics_toolkit('gnuplot')
s=tf('s')

Num_prac = 0.68975;
Den_prac = s*(s*s*0.01524+s*0.2732+1);

lev= Num_prac/Den_prac;


G = tf(lev)

% diseño del controlador
k=1;
z=-1;
p=10*z;
C = zpk([z],[p],k);
L1=C*G;
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

% Para la tensión tenemos la función de sensibilidad

tam_step =0.05; % m
volt=12;

U=(C*tam_step*volt)/(1+C*G);
figure(3)
step(U)
