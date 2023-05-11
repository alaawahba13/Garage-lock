
_initialize_timer_Interrupt:

;MyProject.c,30 :: 		void initialize_timer_Interrupt(void){
;MyProject.c,31 :: 		TMR0IE_bit=1;          // Enable timer 0 interrupt
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;MyProject.c,32 :: 		GIE_bit=1;          //Enable Global Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,33 :: 		T0CS_bit=0;                  // Select f/4 clock for the TMR0
	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
;MyProject.c,34 :: 		PSA_bit=0;                 // Prescaler is assigned to the Timer0 module
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;MyProject.c,35 :: 		PS0_bit=1;                // Set pre-scaler to 32
	BSF        PS0_bit+0, BitPos(PS0_bit+0)
;MyProject.c,36 :: 		PS1_bit=1;                // PS2,PS1,PS0 = 100
	BSF        PS1_bit+0, BitPos(PS1_bit+0)
;MyProject.c,37 :: 		PS2_bit=1;
	BSF        PS2_bit+0, BitPos(PS2_bit+0)
;MyProject.c,38 :: 		TMR0=6;                  //counter starting value
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,39 :: 		}
L_end_initialize_timer_Interrupt:
	RETURN
; end of _initialize_timer_Interrupt

_main:

;MyProject.c,41 :: 		void main() {
;MyProject.c,43 :: 		Motor_Direction = 0;  // Set MOTOR pin as output
	BCF        TRISB7_bit+0, BitPos(TRISB7_bit+0)
;MyProject.c,44 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;MyProject.c,45 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,46 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,47 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,48 :: 		Lcd_Out(1, 1, "Enter Pass:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,49 :: 		initialize_timer_Interrupt();   // invoke timer interrupt initialization function
	CALL       _initialize_timer_Interrupt+0
;MyProject.c,52 :: 		while(1){
L_main0:
;MyProject.c,54 :: 		if(counter==63){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      63
	XORWF      _counter+0, 0
L__main30:
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;MyProject.c,56 :: 		Motor_Pin = 0;  // Turn ff the Motor
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
;MyProject.c,57 :: 		}
L_main2:
;MyProject.c,58 :: 		kp = 0;                                // Reset key code variable
	CLRF       _kp+0
;MyProject.c,59 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;MyProject.c,60 :: 		if(kp && Motor_Pin ==0){
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_main5
L__main27:
;MyProject.c,61 :: 		switch (kp) {
	GOTO       L_main6
;MyProject.c,62 :: 		case  1: kp = '1'; break; // 1        // Uncomment this block for keypad4x4
L_main8:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,63 :: 		case  2: kp = '2'; break; // 2
L_main9:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,64 :: 		case  3: kp = '3'; break; // 3
L_main10:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,65 :: 		case  5: kp = '4'; break; // 4
L_main11:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,66 :: 		case  6: kp = '5'; break; // 5
L_main12:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,67 :: 		case  7: kp = '6'; break; // 6
L_main13:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,68 :: 		case  9: kp = '7'; break; // 7
L_main14:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,69 :: 		case 10: kp = '8'; break; // 8
L_main15:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,70 :: 		case 11: kp = '9'; break; // 9
L_main16:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,71 :: 		case 13: kp = '*'; break; // *
L_main17:
	MOVLW      42
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,72 :: 		case 14: kp = '0'; break; // 0
L_main18:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,73 :: 		case 15: kp = '#'; break; // #
L_main19:
	MOVLW      35
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,74 :: 		}
L_main6:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main19
L_main7:
;MyProject.c,75 :: 		if(kp == '*')
	MOVF       _kp+0, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;MyProject.c,77 :: 		memset(user_password,0,strlen(user_password));
	MOVLW      _user_password+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      FARG_memset_n+0
	MOVF       R0+1, 0
	MOVWF      FARG_memset_n+1
	MOVLW      _user_password+0
	MOVWF      FARG_memset_p1+0
	CLRF       FARG_memset_character+0
	CALL       _memset+0
;MyProject.c,78 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,79 :: 		Lcd_Out(1, 1, "Enter Pass:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,80 :: 		pass_index =0;
	CLRF       _pass_index+0
	CLRF       _pass_index+1
;MyProject.c,81 :: 		}
	GOTO       L_main21
L_main20:
;MyProject.c,82 :: 		else if (kp == '#'){
	MOVF       _kp+0, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;MyProject.c,83 :: 		if(strcmp(My_pass, user_password) == 0){
	MOVLW      _My_pass+0
	MOVWF      FARG_strcmp_s1+0
	MOVLW      _user_password+0
	MOVWF      FARG_strcmp_s2+0
	CALL       _strcmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      0
	XORWF      R0+0, 0
L__main31:
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;MyProject.c,84 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,85 :: 		LCD_Out_CP("CORRECT");
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;MyProject.c,86 :: 		Motor_Pin = 1;  // Turn on the Motor
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
;MyProject.c,87 :: 		counter=0;      // start counter from the beginning
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,88 :: 		}else{
	GOTO       L_main24
L_main23:
;MyProject.c,89 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,90 :: 		LCD_Out_CP("WRONG");
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;MyProject.c,91 :: 		}
L_main24:
;MyProject.c,92 :: 		}else{
	GOTO       L_main25
L_main22:
;MyProject.c,93 :: 		user_password[pass_index] = kp;
	MOVF       _pass_index+0, 0
	ADDLW      _user_password+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
;MyProject.c,94 :: 		pass_index++;
	INCF       _pass_index+0, 1
	BTFSC      STATUS+0, 2
	INCF       _pass_index+1, 1
;MyProject.c,95 :: 		Lcd_Chr_CP('*');
	MOVLW      42
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;MyProject.c,96 :: 		}
L_main25:
L_main21:
;MyProject.c,97 :: 		}
L_main5:
;MyProject.c,98 :: 		}
	GOTO       L_main0
;MyProject.c,99 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,102 :: 		void interrupt() {        // Interrupt handler
;MyProject.c,103 :: 		if (INTCON.TMR0IF==1) {     // check for timer 0 interrupt flag
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt26
;MyProject.c,104 :: 		counter++;                // increment 1 every interrupt
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;MyProject.c,105 :: 		INTCON.TMR0IF=0;          // reset the TMR0IF flag
	BCF        INTCON+0, 2
;MyProject.c,106 :: 		TMR0=6;                   // store 6 in the TMR0 register
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,107 :: 		}
L_interrupt26:
;MyProject.c,108 :: 		}
L_end_interrupt:
L__interrupt33:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
