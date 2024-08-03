#line 1 "C:/Users/maria/OneDrive/Desktop/final project embededd/sw/traffic_light.c"
#line 12 "C:/Users/maria/OneDrive/Desktop/final project embededd/sw/traffic_light.c"
char toggle=1;
char i, units, tens;


char arr[]={23,22,21,20,19,18,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,1,0};
char count=0;
void display(char num) {
 units = num % 10;
 tens = num / 10;
 portC = (units<<4) |(tens&0x0f);

}

void interrupt(){
Delay_ms(500);
while(INTF_bit){
 if(portB.B0==1){INTF_bit=0;}
 if(portB.B1==1) {
  PORTD.B1  = 1;  PORTD.B4 = 1;
  PORTD.B0  = 0;  PORTD.B2  = 0;  PORTD.B3  = 0;  PORTD.B5  = 0;

 portC = (3<<4) |(0&0x0f); Delay_ms(1000);
 portC = (2<<4) |(0&0x0f); Delay_ms(1000);
 portC = (1<<4) |(0&0x0f); Delay_ms(1000);
 portC = (0<<4) |(0&0x0f); Delay_ms(1000);
  PORTD.B0  = toggle;  PORTD.B5  = toggle;  PORTD.B2  = ~toggle;  PORTD.B3 = ~toggle;
  PORTD.B1  = 0;  PORTD.B4  = 0;
 toggle=~toggle;

 }
 }

 }
void automatic() {

 for (i = 0; i <14 ; i++) {
 display(arr[i+8]);
 if (i <11) {
  PORTD.B0  = 1;  PORTD.B1  = 0;  PORTD.B2  = 0;  PORTD.B3  = 0;  PORTD.B4  = 0;  PORTD.B5  = 1;
 } else if (i>=11) {
  PORTD.B0  = 1;  PORTD.B1  = 0;  PORTD.B2  = 0;  PORTD.B3  = 0;  PORTD.B4  = 1;  PORTD.B5 = 0;
 }
 Delay_ms(1000);

 }

 display(0); Delay_ms(1000);


 for (i = 0; i <22; i++) {
 display(arr[i]);
 if (i<19) {
  PORTD.B0  = 0;  PORTD.B1  = 0;  PORTD.B2  = 1;  PORTD.B3  = 1;  PORTD.B4  = 0;  PORTD.B5  = 0;
 } else if(i>=19) {
  PORTD.B0 = 0;  PORTD.B1  = 1;  PORTD.B2  = 0; PORTD.B3  = 1;  PORTD.B4 = 0;  PORTD.B5  = 0;
 }
 Delay_ms(1000);

 }
 display(0); Delay_ms(1000);
 }

void main() {
INTE_bit=1;
GIE_bit=1;
INTEDG_bit=1;
NOT_RBPU_bit=1;
trisD=0x00;
trisB=0x03;
trisC=0x00;

 portB.B4 =1;  portB.B5 =1; portB.B6 =1; portB.B7 =1;
while(1){
 automatic();
 }
}
