
_display:

;traffic_light.c,18 :: 		void display(char num) {
;traffic_light.c,19 :: 		units = num % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_display_num+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__display+0
	MOVF       FLOC__display+0, 0
	MOVWF      _units+0
;traffic_light.c,20 :: 		tens = num / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_display_num+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _tens+0
;traffic_light.c,21 :: 		portC = (units<<4) |(tens&0x0f); //to displaying units and tens on the same port
	MOVF       FLOC__display+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	IORWF      R1+0, 0
	MOVWF      PORTC+0
;traffic_light.c,23 :: 		}
L_end_display:
	RETURN
; end of _display

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;traffic_light.c,25 :: 		void interrupt(){
;traffic_light.c,26 :: 		Delay_ms(500); //delaying to avoid distrbution of instructions
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_interrupt0:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt0
	DECFSZ     R12+0, 1
	GOTO       L_interrupt0
	DECFSZ     R11+0, 1
	GOTO       L_interrupt0
	NOP
	NOP
;traffic_light.c,27 :: 		while(INTF_bit){
L_interrupt1:
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt2
;traffic_light.c,28 :: 		if(portB.B0==1){INTF_bit=0;} //break from interrupt once button is pressed
	BTFSS      PORTB+0, 0
	GOTO       L_interrupt3
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
L_interrupt3:
;traffic_light.c,29 :: 		if(portB.B1==1) {
	BTFSS      PORTB+0, 1
	GOTO       L_interrupt4
;traffic_light.c,30 :: 		s_yellow = 1; w_yellow= 1;
	BSF        PORTD+0, 1
	BSF        PORTD+0, 4
;traffic_light.c,31 :: 		s_red = 0;  s_green = 0; w_red = 0; w_green = 0;
	BCF        PORTD+0, 0
	BCF        PORTD+0, 2
	BCF        PORTD+0, 3
	BCF        PORTD+0, 5
;traffic_light.c,33 :: 		portC = (3<<4) |(0&0x0f);      Delay_ms(1000);
	MOVLW      48
	MOVWF      PORTC+0
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt5:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt5
	DECFSZ     R12+0, 1
	GOTO       L_interrupt5
	DECFSZ     R11+0, 1
	GOTO       L_interrupt5
	NOP
	NOP
;traffic_light.c,34 :: 		portC = (2<<4) |(0&0x0f);      Delay_ms(1000);
	MOVLW      32
	MOVWF      PORTC+0
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt6:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt6
	DECFSZ     R12+0, 1
	GOTO       L_interrupt6
	DECFSZ     R11+0, 1
	GOTO       L_interrupt6
	NOP
	NOP
;traffic_light.c,35 :: 		portC = (1<<4) |(0&0x0f);      Delay_ms(1000);
	MOVLW      16
	MOVWF      PORTC+0
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt7:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt7
	DECFSZ     R12+0, 1
	GOTO       L_interrupt7
	DECFSZ     R11+0, 1
	GOTO       L_interrupt7
	NOP
	NOP
;traffic_light.c,36 :: 		portC = (0<<4) |(0&0x0f);      Delay_ms(1000);
	CLRF       PORTC+0
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt8:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt8
	DECFSZ     R12+0, 1
	GOTO       L_interrupt8
	DECFSZ     R11+0, 1
	GOTO       L_interrupt8
	NOP
	NOP
;traffic_light.c,37 :: 		s_red = toggle; w_green = toggle; s_green = ~toggle; w_red= ~toggle;
	BTFSC      _toggle+0, 0
	GOTO       L__interrupt30
	BCF        PORTD+0, 0
	GOTO       L__interrupt31
L__interrupt30:
	BSF        PORTD+0, 0
L__interrupt31:
	BTFSC      _toggle+0, 0
	GOTO       L__interrupt32
	BCF        PORTD+0, 5
	GOTO       L__interrupt33
L__interrupt32:
	BSF        PORTD+0, 5
L__interrupt33:
	COMF       _toggle+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__interrupt34
	BCF        PORTD+0, 2
	GOTO       L__interrupt35
L__interrupt34:
	BSF        PORTD+0, 2
L__interrupt35:
	BTFSC      R0+0, 0
	GOTO       L__interrupt36
	BCF        PORTD+0, 3
	GOTO       L__interrupt37
L__interrupt36:
	BSF        PORTD+0, 3
L__interrupt37:
;traffic_light.c,38 :: 		s_yellow = 0; w_yellow = 0;
	BCF        PORTD+0, 1
	BCF        PORTD+0, 4
;traffic_light.c,39 :: 		toggle=~toggle;
	MOVF       R0+0, 0
	MOVWF      _toggle+0
;traffic_light.c,41 :: 		}
L_interrupt4:
;traffic_light.c,42 :: 		}
	GOTO       L_interrupt1
L_interrupt2:
;traffic_light.c,44 :: 		}
L_end_interrupt:
L__interrupt29:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_automatic:

;traffic_light.c,45 :: 		void automatic() {
;traffic_light.c,47 :: 		for (i = 0; i < 15 ; i++) {
	CLRF       _i+0
L_automatic9:
	MOVLW      15
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic10
;traffic_light.c,48 :: 		display(arr[i+8]);//to start count from 15
	MOVLW      8
	ADDWF      _i+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_display_num+0
	CALL       _display+0
;traffic_light.c,49 :: 		if (i <11) {
	MOVLW      11
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic12
;traffic_light.c,50 :: 		s_red = 1; s_yellow = 0; s_green = 0; w_red = 0; w_yellow = 0; w_green = 1;  //red and green
	BSF        PORTD+0, 0
	BCF        PORTD+0, 1
	BCF        PORTD+0, 2
	BCF        PORTD+0, 3
	BCF        PORTD+0, 4
	BSF        PORTD+0, 5
;traffic_light.c,51 :: 		} else if (i>=11) {
	GOTO       L_automatic13
L_automatic12:
	MOVLW      11
	SUBWF      _i+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_automatic14
;traffic_light.c,52 :: 		s_red = 1; s_yellow = 0; s_green = 0; w_red  = 0; w_yellow = 1;  w_green= 0;
	BSF        PORTD+0, 0
	BCF        PORTD+0, 1
	BCF        PORTD+0, 2
	BCF        PORTD+0, 3
	BSF        PORTD+0, 4
	BCF        PORTD+0, 5
;traffic_light.c,53 :: 		}
L_automatic14:
L_automatic13:
;traffic_light.c,54 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic15:
	DECFSZ     R13+0, 1
	GOTO       L_automatic15
	DECFSZ     R12+0, 1
	GOTO       L_automatic15
	DECFSZ     R11+0, 1
	GOTO       L_automatic15
	NOP
	NOP
;traffic_light.c,47 :: 		for (i = 0; i < 15 ; i++) {
	INCF       _i+0, 1
;traffic_light.c,56 :: 		}
	GOTO       L_automatic9
L_automatic10:
;traffic_light.c,58 :: 		display(0);  Delay_ms(1000);  //there is some delaying when displaying zero in for loop
	CLRF       FARG_display_num+0
	CALL       _display+0
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic16:
	DECFSZ     R13+0, 1
	GOTO       L_automatic16
	DECFSZ     R12+0, 1
	GOTO       L_automatic16
	DECFSZ     R11+0, 1
	GOTO       L_automatic16
	NOP
	NOP
;traffic_light.c,61 :: 		for (i = 0; i <23; i++) {
	CLRF       _i+0
L_automatic17:
	MOVLW      23
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic18
;traffic_light.c,62 :: 		display(arr[i]);
	MOVF       _i+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_display_num+0
	CALL       _display+0
;traffic_light.c,63 :: 		if (i<19) {
	MOVLW      19
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic20
;traffic_light.c,64 :: 		s_red = 0; s_yellow = 0; s_green = 1; w_red = 1; w_yellow = 0; w_green = 0;
	BCF        PORTD+0, 0
	BCF        PORTD+0, 1
	BSF        PORTD+0, 2
	BSF        PORTD+0, 3
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
;traffic_light.c,65 :: 		} else if(i>=19) {
	GOTO       L_automatic21
L_automatic20:
	MOVLW      19
	SUBWF      _i+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_automatic22
;traffic_light.c,66 :: 		s_red= 0; s_yellow = 1; s_green = 0;w_red = 1; w_yellow= 0; w_green = 0;
	BCF        PORTD+0, 0
	BSF        PORTD+0, 1
	BCF        PORTD+0, 2
	BSF        PORTD+0, 3
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
;traffic_light.c,67 :: 		}
L_automatic22:
L_automatic21:
;traffic_light.c,68 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic23:
	DECFSZ     R13+0, 1
	GOTO       L_automatic23
	DECFSZ     R12+0, 1
	GOTO       L_automatic23
	DECFSZ     R11+0, 1
	GOTO       L_automatic23
	NOP
	NOP
;traffic_light.c,61 :: 		for (i = 0; i <23; i++) {
	INCF       _i+0, 1
;traffic_light.c,70 :: 		}   display(0); Delay_ms(1000);
	GOTO       L_automatic17
L_automatic18:
	CLRF       FARG_display_num+0
	CALL       _display+0
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic24:
	DECFSZ     R13+0, 1
	GOTO       L_automatic24
	DECFSZ     R12+0, 1
	GOTO       L_automatic24
	DECFSZ     R11+0, 1
	GOTO       L_automatic24
	NOP
	NOP
;traffic_light.c,72 :: 		}
L_end_automatic:
	RETURN
; end of _automatic

_main:

;traffic_light.c,74 :: 		void main() {
;traffic_light.c,75 :: 		INTE_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;traffic_light.c,76 :: 		GIE_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;traffic_light.c,77 :: 		INTEDG_bit=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;traffic_light.c,78 :: 		NOT_RBPU_bit=1;
	BSF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;traffic_light.c,79 :: 		trisD=0x00;
	CLRF       TRISD+0
;traffic_light.c,80 :: 		trisB=0x03;
	MOVLW      3
	MOVWF      TRISB+0
;traffic_light.c,81 :: 		trisC=0x00;
	CLRF       TRISC+0
;traffic_light.c,83 :: 		sw1=1; sw2=1;sw3=1;sw4=1;
	BSF        PORTB+0, 4
	BSF        PORTB+0, 5
	BSF        PORTB+0, 6
	BSF        PORTB+0, 7
;traffic_light.c,84 :: 		while(1){
L_main25:
;traffic_light.c,85 :: 		automatic();
	CALL       _automatic+0
;traffic_light.c,86 :: 		}
	GOTO       L_main25
;traffic_light.c,87 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
