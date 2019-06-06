%Octave
%graphics_toolkit("gnuplot");
%pkg load  control
%pkg load symbolic
% diseño del controlador para el levitador por el lugar de las raices

tao = 0.1
K= 1
p1 = 4.85
%%

s=tf('s')

Num_prac = 0.68975;
Den_prac = s*(s*s*0.01524+s*0.2732+1);

lev= Num_prac/Den_prac;


G = tf(lev)


% diseño del controlador
k=6
z1=-0.3
z2=-5
p1=0
p2=-40
p= [p1 p2]

%k=1
%z1 = -20+0.01*j
%z2= conj(z1)
z = [z1 z2]
%p=[0 10*real(z1)]
%p=0
C = zpk([z],[p],k);
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
tee = 2;
SP = .2;
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
step(U)
%axis ([0 1 ]) % -0.3 14])
%figure(3)
%step(T)

