%Donde Theta_ref = 0
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
G = ( -H1 + H3 )/( D*s*s -a*H1 );
%% Red de atraso%%
k = 1200;
z = 25;
p = 180;
C = k*((s+z)/(s+p));
figure(3)
sys = feedback(C*G,1);
rlocus(C*G);
figure(4)
step(sys);
%% Respuesta a perturbacion
P = G/(1+C*G);
figure(5)
impulse(5*P);



