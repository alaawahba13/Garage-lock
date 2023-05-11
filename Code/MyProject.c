unsigned short kp;
char key;
char user_password[20];
char My_pass[] = "1234";
 //timer
  int counter=0, pass_index =0;

// Keypad module connections
char  keypadPort at PORTD;

// LCD module connections
sbit LCD_RS at RC4_bit;
sbit LCD_EN at RC5_bit;
sbit LCD_D4 at RC0_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D7 at RC3_bit;

sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D4_Direction at TRISC0_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D7_Direction at TRISC3_bit;

//Motor
sbit Motor_Pin at RB7_bit;
sbit Motor_Direction at TRISB7_bit;

void initialize_timer_Interrupt(void){
    TMR0IE_bit=1;          // Enable timer 0 interrupt
    GIE_bit=1;          //Enable Global Interrupt
    T0CS_bit=0;                  // Select f/4 clock for the TMR0
    PSA_bit=0;                 // Prescaler is assigned to the Timer0 module
    PS0_bit=0;                // Set pre-scaler to 8
    PS1_bit=1;                // PS2,PS1,PS0 = 010
    PS2_bit=0;
    TMR0=6;                  //counter starting value
}

void main() {
//Init
  Motor_Direction = 0;  // Set MOTOR pin as output
  Keypad_Init();
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
  Lcd_Out(1, 1, "Enter Pass:");
  initialize_timer_Interrupt();   // invoke timer interrupt initialization function


while(1){

if(counter==2000){
 // check if the counter reaches 2000
      Motor_Pin = 0;  // Turn ff the Motor
 }
      kp = 0;                                // Reset key code variable
      kp = Keypad_Key_Click();             // Store key code in kp variable
if(kp && Motor_Pin ==0){
      switch (kp) {
      case  1: kp = '1'; break; // 1        // Uncomment this block for keypad4x4
      case  2: kp = '2'; break; // 2
      case  3: kp = '3'; break; // 3
      case  5: kp = '4'; break; // 4
      case  6: kp = '5'; break; // 5
      case  7: kp = '6'; break; // 6
      case  9: kp = '7'; break; // 7
      case 10: kp = '8'; break; // 8
      case 11: kp = '9'; break; // 9
      case 13: kp = '*'; break; // *
      case 14: kp = '0'; break; // 0
      case 15: kp = '#'; break; // #
       }
if(kp == '*')
   {
        memset(user_password,0,strlen(user_password));
        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out(1, 1, "Enter Pass:");
        pass_index =0;
   }
else if (kp == '#'){
         if(strcmp(My_pass, user_password) == 0){
                   Lcd_Cmd(_LCD_CLEAR);
                   LCD_Out_CP("CORRECT");
                   Motor_Pin = 1;  // Turn on the Motor
                   counter=0;      // start counter from the beginning
           }else{
                     Lcd_Cmd(_LCD_CLEAR);
                   LCD_Out_CP("WRONG");
         }
}else{
  user_password[pass_index] = kp;
  pass_index++;
  Lcd_Chr_CP('*');
     }
   }
   }
 }


void interrupt() {        // Interrupt handler
  if (INTCON.TMR0IF==1) {     // check for timer 0 interrupt flag
    counter++;                // increment 1 every interrupt
    INTCON.TMR0IF=0;          // reset the TMR0IF flag
    TMR0=6;                   // store 6 in the TMR0 register
  }
}