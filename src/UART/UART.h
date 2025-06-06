//
// Created by Harry Skerritt on 03/06/2025.
//

#ifndef UART_H
#define UART_H

typedef unsigned int   uint32_t;
typedef unsigned short uint16_t;
typedef unsigned char  uint8_t;


void uart_init(void);
void uart_putc(char c);
void uart_puts(const char* s);

#endif //UART_H
