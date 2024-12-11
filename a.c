#define __AVR_ATmega328P__

#include <avr/io.h>
#include <util/delay.h>

int main(void){

    DDRB |= (1<<PB0); // inital for PORT-B and enable pin 1st

    while (1)
    {
        PORTB = 0x01;  //  write under hex
        _delay_ms(1000);

        PORTB = 0x00;
        _delay_ms(1000);
    }

    return 0;
    

}

        // // Turn PB0 ON
        // PORTB |= (1 << PB0);  // Set PB0 to HIGH
        // _delay_ms(1000);

        // // Turn PB0 OFF
        // PORTB &= ~(1 << PB0); // Set PB0 to LOW
        // _delay_ms(1000);