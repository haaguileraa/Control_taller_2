#include "TimerOne.h"

float  ttime = 0;

//--------Constantes de la planta---------//

float u = 0;  //Ventilador
float ro = 1.223; //Densidad del aire seco
float Cd = 0.5;   //Coeficiente aerodinamico de la esfera.
float alpha = Cd * ro / 2; //Constante de presión del aire
float tao = 0.1;  //Constante motor
float k = 1;    //Constante motor
float m = 0.4;  //Masa bolita
float g = 9.8;  //Gravedad
float L = 0.1;   //Largo de la probeta

//Planta
float x1, x2, Va = 0;
float dx1, dx2, dVa;
float Van;




//---------PI---------//
//Variable timer
int Fs = 1000; //Frecuencia de Operación
float D = (float)1 / Fs;  //Tiempo de muestreo
long Ts = 1000000 / Fs;   //Tiempo del timer 5ms
int n = 0;    //Variable para cambiar la referencia
//float
float r = 1;//L/2;  //Referencia
float e = 0;  //Error

//Control proporcional
float kp = 3.1;
float P = 0;
//Control integral
float ki = 1.2;
float kib = ki * D;
float I = 0, Iant = 0;
//Control derivativo
float kd = 0.225;
float kdb = kd * D;
float Der = 0, eant = 0;
//---control 
float z1=0;
float z1ant;



//--------------SETUP-----------//
void setup() {
  Serial.begin(115200);
  // timer para ajustar la interrupcion
  Timer1.initialize(Ts);
  Timer1.attachInterrupt(control);
  
}

void control()
{
  

   
  
  
 


  //----------- Control -------------//
  e = r - x1;

  
  P = kp * e; //Proporcional
  I = Iant + kib * e; //Integral
  Der= kdb*(e-eant);
  u = (P + I + Der)/12;  //señal de control
  
  if (u>12) u=12;
  Iant = I; // */
  eant=e;
  
  
 
  z1ant = 0.9822*z1 -0.0650*x2 + 0.9822*u ;
  dx2 = D*z1+x2;
  dx1 = D*x2 + x1;
  
  
  
  

  
  x1 = dx1;
  x2 = dx2;
  z1 = z1ant; // */
  
  if(x1<0){
   x1=0;
   x2=0;
    }

  

     
    Serial.print(millis());
    Serial.print(" ");
    Serial.println(x1);
   
}
void loop() {
 
    
}
