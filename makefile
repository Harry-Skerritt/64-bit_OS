osname := $(shell uname -s)

CROSS_PREFIX=aarch64-elf-

all: clean kernel.img

startup.o: startup.s
	$(CROSS_PREFIX)as -c $< -o $@

test.o: test.c
	$(CROSS_PREFIX)gcc -c $< -o $@

kernel.elf: test.o startup.o
	$(CROSS_PREFIX)ld -T test.ld $^ -o $@

kernel.img: kernel.elf
	$(CROSS_PREFIX)objcopy -O binary $< $@

clean:
	rm -f kernel.img kernel.elf startup.o test.o