#include <WiFi.h>
#include <IOXhop_FirebaseESP32.h>
#include <ArduinoJson.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

const char* firebaseHost = "";
const char* firebaseAuth = "";

const char* ssid = "";
const char* passwd = "";

int ledVermelho = 15;
int ledVerde = 2;
int rele = 4;
bool acionou = false;
bool verificou = false;
void setup() {
  Serial.begin(9600);
  lcd.begin();
  lcd.clear();
  pinMode(ledVermelho, OUTPUT);
  pinMode(ledVerde, OUTPUT);
  pinMode(rele, OUTPUT);
  
  
  delay(300);
  initConnection();
  
  Firebase.begin(firebaseHost, firebaseAuth);
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Carregando!");
  Firebase.remove("/registerTemp");
  delay(1000);
  lcd.clear();
}

String dados = "";

void loop() {
  if(verificou == false){
    trancado();
    delay(200);
  }else{
    aberto();
    delay(10000);
    verificou = false;
  }
  dados = Firebase.getString("/registerTemp");
  if(dados != ""){
    verificou = true;
    Firebase.remove("/registerTemp");
    dados = "";
  }
}

void trancado(){
  if(acionou == false){
    lcd.clear();
    digitalWrite(rele,LOW); 
    acionou = true;
  }   
  lcd.setCursor(0, 0);
  lcd.print("TRANCADO!");
  digitalWrite(ledVermelho, HIGH);
  digitalWrite(ledVerde, LOW);
}

void aberto(){
  if(acionou == true){
    lcd.clear();
    digitalWrite(rele, HIGH); 
    acionou = false;
  }
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("ABERTO!");
  digitalWrite(ledVermelho, LOW);
  digitalWrite(ledVerde, HIGH);
}

void initConnection() {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("SecureDoor");
  delay(300);
  WiFi.begin(ssid, passwd);

  lcd.setCursor(0, 1);
  while (WiFi.status() != WL_CONNECTED)
  {
    lcd.print(".");
    delay(300);
  }
  Serial.println();
}
