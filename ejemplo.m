

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


%% Ejemplo PI
clear 
clc
s=tf('s')
G=zpk([],[-0.8 -1 -0.25], 0.2)

% diseño del controlador
k=0.9;
z=-0.25;
p=0;
C = zpk(z,p,k)
%C=k
L1=C*G;
T=feedback(L1,1)
plc=pole(T);



S=1-T;
ep = dcgain(S)

% plot de la region de diseno
delete(gcf)
figure(1)
rlocus(L1)
axis ([-2.5 0.2 -7 7])
tee = 25
SP = 0.1
sigma = 5/tee
zeta = abs(log(SP))/sqrt(pi^2+(log(SP))^2)
teta = acos(zeta)
h = gca()
xscale = get(h,'xlim');
yscale = get(h,'ylim');
line([0 -yscale(2)/tan(teta)], [0 yscale(2)], 'color','g', 'linestyle','--')
line([0 yscale(1)/tan(teta)], [0 yscale(1)], 'color','g','linestyle','--')
l=line([-sigma -sigma], [yscale(1) yscale(2)], 'color','g','linestyle','--')


for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end

figure(2)
step(T)

