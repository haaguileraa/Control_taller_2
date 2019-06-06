

s=tf('s')

Num_prac = 2;
Den_prac = s*(s+1)*(s+4);

lev= Num_prac/Den_prac;


%G = tf(lev)

G=zpk([],[0 -1 -4], 2)

% diseño del controlador
k=42.5;
z=-1.1;
p=-20;
C = zpk(z,p,k)
L1=C*G;
T=feedback(L1,1);
plc=pole(T);

% plot de la region de diseno
delete(gcf)
figure(1)
rlocus(L1)
axis ([-2.5 0.2 -7 7])

for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end

figure(2)
step(T)