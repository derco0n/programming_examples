//Arduino Mega: CPU-Debugger for the 6502
// Based on the work of Ben Eater (eater.net)
//Written and modified by D. Marx
//20200727
char *OPCODES[] = {
"BRK",
"ORA (zp,X)",
"HALT",
"ASL-ORA (zp,X)",
"NOP zp",
"ORA zp",
"ASL zp",
"ASL-ORA zp",
"PHP",
"ORA #n",
"ASL A",
"AND #n/MOV b7->Cy",
"NOP abs",
"ORA abs",
"ASL abs",
"ASL-ORA abs",
"BPL rel",
"ORA (zp),Y",
"HALT",
"ASL-ORA (zp),Y",
"NOP zp",
"ORA zp,X",
"ASL zp,X",
"ASL-ORA abs,X",
"CLC",
"ORA abs,Y",
"NOP",
"ASL-ORA abs,Y",
"NOP abs",
"ORA abs,X",
"ASL abs,X",
"ASL-ORA abs,X",
"JSR abs",
"AND (zp,X)",
"HALT",
"ROL-AND (zp,X)",
"BIT zp",
"AND zp",
"ROL zp",
"ROL-AND zp",
"PLP",
"AND #n",
"ROL A",
"AND #n-MOV b7->Cy",
"BIT abs",
"AND abs",
"ROL abs",
"ROL-AND abs",
"BMI rel",
"AND (zp),Y",
"HALT",
"ROL-AND (zp),Y",
"NOP zp",
"AND zp,X",
"ROL zp,X",
"ROL-AND zp,X",
"SEC",
"AND abs,Y",
"NOP",
"ROL-AND abs,Y",
"NOP abs",
"ORA abs,X",
"ASL abs,X",
"ROL-AND abs,X",
"RTI",
"EOR (zp,X)",
"HALT",
"LSR-EOR (zp,X)",
"NOP zp",
"EOR zp",
"LSR zp",
"LSR-EOR zp",
"PHA",
"EOR #n",
"LSR A",
"AND #n-LSR A",
"JMP abs",
"EOR abs",
"LSR abs",
"LSR-EOR abs",
"BVC rel",
"EOR (zp),Y",
"HALT",
"LSR-EOR (zp),Y",
"NOP zp",
"EOR zp,X",
"LSR zp,X",
"LSR-EOR abs,X",
"CLI",
"EOR abs,Y",
"NOP",
"LSR-EOR abs,Y",
"NOP abs",
"EOR abs,X",
"LSR abs,X",
"LSR-EOR abs,X",
"RTS",
"ADC (zp,X)",
"HALT",
"ROR-ADC (zp,X)",
"NOP zp",
"ADC zp",
"ROR zp",
"ROR-ADC zp",
"PLA",
"ADC #n",
"ROR A",
"AND #n-ROR A",
"JMP (abs)",
"ADC abs",
"ROR abs",
"ROR-ADC abs",
"BCS rel",
"ADC (zp),Y",
"HALT",
"ROR-ADC (zp),Y",
"NOP zp",
"ADC zp,X",
"ROR zp,X",
"ROR-ADC abs,X",
"SEI",
"ADC abs,Y",
"NOP",
"ROR-ADC abs,Y",
"NOP abs",
"ADC abs,X",
"ROR abs,X",
"ROR-ADC abs,X",
"NOP zp",
"STA (zp,X)",
"HALT",
"STA-STX (zp,X)",
"STY zp",
"STA zp",
"STX zp",
"STA-STX zp",
"DEY",
"NOP zp",
"TXA A",
"TXA-AND #n",
"STY abs",
"STA abs",
"STX abs",
"STA-STX abs",
"BCC rel",
"STA (zp),Y",
"HALT",
"STA-STX (zp),Y",
"STY zp",
"STA zp,X",
"STX zp,Y",
"STA-STX zp,Y",
"TYA",
"STA abs,Y",
"TXS",
"STA-STX abs,Y",
"STA-STX abs,X",
"STA abs,X",
"STA-STX abs,X",
"STA-STX abs,X",
"LDY #n",
"LDA (zp,X)",
"LDX #n",
"LDA-LDX (zp,X)",
"LDY zp",
"LDA zp",
"LDX zp",
"LDA-LDX zp",
"TAY",
"LDA #n",
"TAX",
"LDA-LDX",
"LDY abs",
"LDA abs",
"LDX abs",
"LDA-LDX abs",
"BCS rel",
"LDA (zp),Y",
"HALT",
"LDA-LDX (zp),Y",
"LDY zp",
"LDA zp,X",
"LDX zp,Y",
"LDA-LDX zp,Y",
"CLV",
"LDA abs,Y",
"TSX",
"LDA-LDX abs,Y",
"LDY abs,X",
"LDA abs,X",
"LDX abs,Y",
"LDA-LDX abs,Y",
"CPY #n",
"CMP (zp,X)",
"HALT",
"DEC-CMP (zp,X)",
"CPY zp",
"CMP zp",
"DEC zp",
"DEC-CMP zp",
"INY",
"CMP #n",
"DEX",
"SBX #n",
"CPY abs",
"CMP abs",
"DEC abs",
"DEC-CMP abs",
"BNE rel",
"CMP (zp),Y",
"HALT",
"DEC-CMP (zp),Y",
"NOP zp",
"CMP zp,X",
"DEC zp,X",
"DEC-CMP zp,X",
"CLD",
"CMP abs,Y",
"NOP",
"DEC-CMP abs,Y",
"NOP abs",
"CMP abs,X",
"DEC abs,X",
"DEC-CMP abs,X",
"CPX #n",
"SBC (zp,X)",
"HALT",
"INC-SBC (zp,X)",
"CPX zp",
"SBC zp",
"INC zp",
"INC-SBC zp",
"INX",
"SBC #n",
"NOP",
"SBC #n",
"CPX abs",
"SBC abs",
"INC abs",
"INC-SBC abs",
"BEQ rel",
"SBC (zp),Y",
"HALT",
"INC-SBC (zp),Y",
"NOP zp",
"SBC zp,X",
"INC zp,X",
"INC-SBC zp,X",
"SED",
"SBC abs,Y",
"NOP",
"INC-SBC abs,Y",
"NOP abs",
"SBC abs,X",
"INC abs,X",
"INC-SBC abs,X"
  };

const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52}; //Pins for the adresslines (16-Bit)
const char DATA[] = {39, 41, 43, 45, 47, 49, 51, 53}; //Pins for the datalines (8-Bit)
unsigned int step;
#define CLOCK_IN 2 //Input for external generated Clocksignal
#define SINGLESTEP_IN 5 //Input for single stepping the clock
//#define CLOCK_OUT 4 //Output for locally generated clocksignal
#define READ_WRITE 3 //Input for READ-Write-Signal

void setup () {
  step=0;
  for (int n=0; n<16; n+=1){
    pinMode(ADDR[n], INPUT);
    }
  for (int n=0; n<8; n+=1){
    pinMode(DATA[n], INPUT);
    }

  pinMode(CLOCK_IN, INPUT);
  
  pinMode(SINGLESTEP_IN, INPUT);
  
  pinMode(READ_WRITE, INPUT);
  attachInterrupt(digitalPinToInterrupt(CLOCK_IN), onClock, RISING);
    
  Serial.begin(57600);
  Serial.println();
  Serial.println("6502-CPU-Debugger:");
  Serial.println("##################");
  Serial.println("Please note: every data will be translated to opcodes, even if it is not an actual instruction and some instructions might need more than one clock cycle.");
  Serial.println("");
}

/*
void StepClock(){
  //Serial.println("Stepping One Clock Cycle"); //DEBUG
  //Trigger a clock pulse  
  digitalWrite(CLOCK_OUT, LOW);
  pinMode(CLOCK_OUT, OUTPUT);  
  delay(100);
  digitalWrite(CLOCK_OUT, HIGH);
  delay(100);
  digitalWrite(CLOCK_OUT, LOW);
  delay(500);
  pinMode(CLOCK_OUT, INPUT);  
  }
*/
void onClock() {
  
  char output[250];
  Serial.print(step);
  Serial.print(": ");
  
  unsigned int address = 0;
  for (int n=0; n<16; n+=1){
      int bit = digitalRead(ADDR[n]) ? 1 : 0;
      Serial.print(bit);
      address = (address << 1) + bit;
      }
      
  Serial.print("  ");
  
  unsigned int data = 0;
  for (int n=0; n<8; n+=1){
      int bit = digitalRead(DATA[n]) ? 1 : 0;
      Serial.print(bit);
      data = (data << 1) + bit;      
      }
  
  sprintf (output, "  %04x %c %02x (%s)", address, digitalRead(READ_WRITE) ? 'r' : 'W', data, OPCODES[data]);
  Serial.println(output);
  
  //Serial.println();
  step++;
}

void loop() {
  /*
  if (digitalRead(SINGLESTEP_IN) == HIGH){
    detachInterrupt(digitalPinToInterrupt(CLOCK_IN));
    StepClock();
    }
  else { */
    attachInterrupt(digitalPinToInterrupt(CLOCK_IN), onClock, RISING);
  //}
  
}
