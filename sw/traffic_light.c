#define  s_red PORTD.B0
#define s_yellow PORTD.B1
#define s_green PORTD.B2
#define  w_red PORTD.B3
#define  w_yellow PORTD.B4
#define w_green PORTD.B5
#define sw1 portB.B4
#define sw2 portB.B5
#define sw3 portB.B6
#define sw4 portB.B7

char toggle=1;
char i, units, tens;

//for loop to count down make some uncorrect instructions
char arr[]={23,22,21,20,19,18,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,1,0};
char count=0;
void display(char num) {
    units = num % 10;
    tens = num / 10;
    portC = (units<<4) |(tens&0x0f); //to displaying units and tens on the same port

}

void interrupt(){
Delay_ms(500); //delaying to avoid distrbution of instructions
while(INTF_bit){
 if(portB.B0==1){INTF_bit=0;} //break from interrupt once button is pressed
  if(portB.B1==1) {
  s_yellow = 1; w_yellow= 1;
      s_red = 0;  s_green = 0; w_red = 0; w_green = 0;
      //displaying 3 seconds on 7 seg
       portC = (3<<4) |(0&0x0f);      Delay_ms(1000);
       portC = (2<<4) |(0&0x0f);      Delay_ms(1000);
       portC = (1<<4) |(0&0x0f);      Delay_ms(1000);
       portC = (0<<4) |(0&0x0f);      Delay_ms(1000);
    s_red = toggle; w_green = toggle; s_green = ~toggle; w_red= ~toggle;
        s_yellow = 0; w_yellow = 0;
      toggle=~toggle;

   }
        }

       }
void automatic() {

        for (i = 0; i <15 ; i++) {
            display(arr[i+8]);//to start count from 15
            if (i <11) {
              s_red = 1; s_yellow = 0; s_green = 0; w_red = 0; w_yellow = 0; w_green = 1;  //red and green
            } else{
               s_red = 1; s_yellow = 0; s_green = 0; w_red  = 0; w_yellow = 1;  w_green= 0;
            }
            Delay_ms(1000);

        }




        for (i = 0; i <23; i++) {
            display(arr[i]);
            if (i<19) {
               s_red = 0; s_yellow = 0; s_green = 1; w_red = 1; w_yellow = 0; w_green = 0;
            } else{
               s_red= 0; s_yellow = 1; s_green = 0;w_red = 1; w_yellow= 0; w_green = 0;
            }
            Delay_ms(1000);

        }

    }

void main() {
INTE_bit=1;
GIE_bit=1;
INTEDG_bit=1;
NOT_RBPU_bit=1;
trisD=0x00;
trisB=0x03;
trisC=0x00;
//turning on the 7 seg
sw1=1; sw2=1;sw3=1;sw4=1;
while(1){
   automatic();
      }
}