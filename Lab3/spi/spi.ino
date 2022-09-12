
//SPI SLAVE (ARDUINO)
//CIRCUIT DIGEST
//Pramoth.T

#include<SPI.h>

volatile boolean received;
volatile byte Slavereceived,Slavesend;
int buttonvalue;
int Send;
int buf;
void setup()

{
  Serial.begin(115200);
  

  pinMode(MISO,OUTPUT);                   //Sets MISO as OUTPUT (Have to Send data to Master IN 
  
  SPCR |= _BV(SPE);                       //Turn on SPI in Slave Mode
  //SPISettings mySetting(6250000, LSBFIRST, SPI_MODE1);
  //SPISettings(6250000, MSBFIRST, SPI_MODE1);
  received = false;
  SPI.setBitOrder(LSBFIRST);
  SPI.setDataMode(SPI_MODE1);
  SPI.attachInterrupt();                  //Interrupt ON is set for SPI commnucation
  
}

ISR (SPI_STC_vect)                        //Inerruput routine function 
{
  Slavereceived = SPDR;         // Value received from master if store in variable slavereceived

  received = true;                        //Sets received as True 
  
}

void loop()
{ 
buf=Serial.available();
  if ( Serial.available()) // Check to see if at least one character is available
  {
    Send = Serial.parseInt();
      
      Serial.print("Dato a enviar : ");
      Serial.println(Send);
      Serial.println();
   // send = (send - '0'); 
   Slavesend=Send; 
   SPDR = Slavesend; 
  }
  
  if(received)                     
   {

                              
  
        SPDR = Slavesend;
        Serial.print("Se recibió un dato:");
        Serial.println(Slavereceived);
        Serial.print("Se envió un dato:");
        Serial.println(Slavesend);
        Serial.println();

  received = false;  
      
   
}

}
