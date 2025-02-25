#include "BluetoothSerial.h"

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

BluetoothSerial SerialBT;
void setup()
{
  SerialBT.begin("ESP32vip");
}

void loop()
{
  analogSetAttenuation(ADC_6db);
  int v=analogRead(35);
  float voltaje=(8.0/4095.0)*v;
  
  analogSetAttenuation(ADC_0db);
  int i=analogRead(34);
  float corriente=(20.0/4095.0)*i;
  float potencia=voltaje*corriente;

  SerialBT.print(voltaje);
  SerialBT.print(',');
  SerialBT.print(corriente);
  SerialBT.print(',');
  SerialBT.println(potencia);
}