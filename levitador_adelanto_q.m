% diseno del controlador para el levitador por el lugar de las raices
% definimos las matrices de estado
%graphics_toolkit('gnuplot')
tao = 0.1
K= 1
p1 = 4.85

A = [0 1 0; 0 -p1 p1; 0 0 -1/tao]
B = [0 0 K/tao]'
C = [1 0 0]

levv = ss(A,B,C,0)

G=tf(levv)

lev=tf(0.68975,[0.01524 0.2732 1 0])


GG = tf(lev)

% dise�o del controlador
k=1
z1=-1
p1=10*z1
C = zpk([z1],[p1],k);
L1=C*G;
T=feedback(L1,1);
plc=pole(T)


% plot de la region de diseno
delete(gcf)
rlocus(L1)
tee = 2
SP = .2
sigma = 5/tee
zeta = abs(log(SP))/sqrt(pi^2+(log(SP))^2)
teta = acos(zeta)
h = gca()
xscale = get(h,'xlim');
yscale = get(h,'ylim');
line([0 -yscale(2)/tan(teta)], [0 yscale(2)], 'color','g', 'linestyle','--')
line([0 yscale(1)/tan(teta)], [0 yscale(1)], 'color','g','linestyle','--')
l=line([-sigma -sigma], [yscale(1) yscale(2)], 'color','g','linestyle','--')

var=c2d(C,10^-3)

cdva=ss(var)



for i =1 : length(plc)
  line(real(plc(i)), imag(plc(i)),  'marker','square', 'color','r', 'markersize', 8)
end

figure(2)
step(T)
grid on


tam_step =0.05; % m
volt=12;

U=(C*tam_step*volt)/(1+C*G);
figure(3)
step(U)
grid on