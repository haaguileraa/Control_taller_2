#include "TimerOne.h"

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
int Van;




//---------PI---------//
//Variable timer
int Fs = 1000; //Frecuencia de Operación
float D = (float)1 / Fs;  //Tiempo de muestreo
long Ts = 1000000 / Fs;   //Tiempo del timer 5ms
int n = 0;    //Variable para cambiar la referencia
//float
float r = 0;//L/2;  //Referencia
float e = 0;  //Error

//Control proporcional
float kp = 2;//2;
float P = 0;
//Control integral
float ki = 1;//1;
float kib = ki * D;
float I = 0, Iant = 0;


float alt =0;
float desv = 0.01; //desviamos 1cm
//---control 
float z=0;
float zant=0;


//--------------SETUP-----------//
void setup() {
  Serial.begin(9600);
  // timer para ajustar la interrupcion
  Timer1.initialize(Ts);
  Timer1.attachInterrupt(control);
}

void control()
{
  
  alt =0.05;
  ki=1;
  kp=2;
  n += 1;
   if (n % 1500 == 0) {//2500 == 0) {
   if (r < (alt)) {
      r = alt+desv;
    }
    else
      r = alt+desv;
  } // */

  
 


  //----------- Control -------------//
  e = r - x1;

  /*
  P = kp * e; //Proporcional
  I = Iant + kib * e; //Integral
  u = P + I;  //señal de control
  if (u>12) u=12;
  Iant = I; */
  //----------Adelanto  
  z = 0.0995*zant + 0.2527*e;
  u = (-0.3158*zant + 20*e)*12;
  
  /*
  z = 0.0995*zant + 0.2527*e;
  u = (-0.1579*zant + 10*e)*12; */
  
  
  zant=z;

  
  Van=(Va - x2);
  dx1 = D*x2 + x1;
  dx2 = D*alpha / m * sq(Van) - D*g + x2;
  dVa = -D / tao * Va + D* k / tao * u + Va;

  

  
  x1 = dx1;
  x2 = dx2;
  Va = dVa;
  if(x1>30){
    x1=30;
  }
  if(x1<0){
    x1=0;
    x2=0;
  }
    
    Serial.print(x1*10);
    Serial.print(" ");// */
  /*  Serial.print(e);
    Serial.print(" "); // */
    Serial.print(r*10);
    Serial.print(" "); 
    /* */
    Serial.println(u); // */
    /* 
    Serial.print(kp);
    Serial.print(" ");
    Serial.println(ki); // */
}
void loop() {
 
}
