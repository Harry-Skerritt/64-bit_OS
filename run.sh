#/!bin/sh

echo "Running emulator"

qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -kernel build/kernel.img
