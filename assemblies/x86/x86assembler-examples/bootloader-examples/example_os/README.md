# Example-OS
Based on the tutorial of https://dev.to/frosnerd/

This is an example of an basic operating systemt, consisting of 
- an bootloader starting a self-written kernel.


## Files
- mbr.asm 
	- is the main file defining the master boot record (512 byte boot sector)
- disk.asm
	- contains code to read from disk using BIOS
- gdt.asm
	- sets up the GDT
- switch-to-32bit.asm
	- contains code to switch to 32 bit protected mode
- kernel-entry.asm
	- contains assembler code to hand over to our main function in kernel.c
- kernel.c
	- contains the main function of the kernel
- Makefile
	- wires the compiler, linker, assembler and emulator together so we can boot our operating system

