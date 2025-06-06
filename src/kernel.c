#include "UART/UART.h"

void kernel_main() {
    uart_init();
    uart_puts("Hello from Kernel!\n");
}