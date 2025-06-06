osname := $(shell uname -s)

CROSS_PREFIX = aarch64-elf-
SRC_DIR     = src
BLD_DIR     = build

# Main target: just build the kernel image
all: $(BLD_DIR)/kernel.img

# Run-once: clean old .img, build new one, keep it, clean everything else
build-once:
	rm -f $(BLD_DIR)/kernel.img
	$(MAKE) all
	cp $(BLD_DIR)/kernel.img ./kernel.img
	$(MAKE) clean
	mv ./kernel.img $(BLD_DIR)/kernel.img

# Ensure build directory exists
$(BLD_DIR):
	mkdir -p $@

# Build startup
$(BLD_DIR)/startup.o: $(SRC_DIR)/startup.s | $(BLD_DIR)
	$(CROSS_PREFIX)as -c $< -o $@

# Build kernel
$(BLD_DIR)/kernel.o: $(SRC_DIR)/kernel.c | $(BLD_DIR)
	$(CROSS_PREFIX)gcc -c -ffreestanding -nostdlib -O2 -Wall -Wextra $< -o $@

# Build UART
$(BLD_DIR)/uart.o: $(SRC_DIR)/UART/UART.c $(SRC_DIR)/UART/UART.h | $(BLD_DIR)
	$(CROSS_PREFIX)gcc -c -ffreestanding -nostdlib -O2 -Wall -Wextra $< -o $@

# Link ELF
$(BLD_DIR)/kernel.elf: $(BLD_DIR)/kernel.o $(BLD_DIR)/startup.o $(BLD_DIR)/uart.o
	$(CROSS_PREFIX)ld -T src/linker.ld $^ -o $@

# Convert to binary image
$(BLD_DIR)/kernel.img: $(BLD_DIR)/kernel.elf
	$(CROSS_PREFIX)objcopy -O binary $< $@

# Clean all except .img
clean:
	rm -f $(BLD_DIR)/*.o $(BLD_DIR)/kernel.elf
