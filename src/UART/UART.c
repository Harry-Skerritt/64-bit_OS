//
// Created by Harry Skerritt on 03/06/2025.
//

#include "UART.h"

// UART Base address for the QEMU virt machine
#define UART0_BASE 0x09000000UL

// UART Register offsets
#define UART_DR (*((volatile uint32_t*)UART0_BASE + 0x00)) // Data Register
#define UART_FR (*((volatile uint32_t*)UART0_BASE + 0x18)) // Flag register

// UART Flag register bits
#define UART_FR_TXFF (1 << 5) // FIFO

void uart_init(void) {
    //Todo: Add this later
}

void uart_putc(char c) {
    while(UART_FR & UART_FR_TXFF) { }
    UART_DR = (uint32_t)c;
}

void uart_puts(const char *s)
{
    while(*s) {
        if(*s == '\n') {
            uart_putc('\r'); // EOL - Carriage return
        }
        uart_putc(*s++);
    }
}
