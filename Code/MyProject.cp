#line 1 "C:/Users/Qebaa/OneDrive/Documents/mikroC PRO for PIC/task3/MyProject.c"
unsigned short kp;
char key;
char user_password[20];
char My_pass[] = "1234";

 int counter=0, pass_index =0;


char keypadPort at PORTD;


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


sbit Motor_Pin at RB7_bit;
sbit Motor_Direction at TRISB7_bit;

void initialize_timer_Interrupt(void){
 TMR0IE_bit=1;
 GIE_bit=1;
 T0CS_bit=0;
 PSA_bit=0;
 PS0_bit=1;
 PS1_bit=1;
 PS2_bit=1;
 TMR0=6;
}

void main() {

 Motor_Direction = 0;
 Keypad_Init();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Enter Pass:");
 initialize_timer_Interrupt();


while(1){

if(counter==63){

 Motor_Pin = 0;
 }
 kp = 0;
 kp = Keypad_Key_Click();
if(kp && Motor_Pin ==0){
 switch (kp) {
 case 1: kp = '1'; break;
 case 2: kp = '2'; break;
 case 3: kp = '3'; break;
 case 5: kp = '4'; break;
 case 6: kp = '5'; break;
 case 7: kp = '6'; break;
 case 9: kp = '7'; break;
 case 10: kp = '8'; break;
 case 11: kp = '9'; break;
 case 13: kp = '*'; break;
 case 14: kp = '0'; break;
 case 15: kp = '#'; break;
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
 Motor_Pin = 1;
 counter=0;
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


void interrupt() {
 if (INTCON.TMR0IF==1) {
 counter++;
 INTCON.TMR0IF=0;
 TMR0=6;
 }
}
