# Example-OS
Based on the tutorial of https://dev.to/frosnerd/

This is an example of an basic operating systemt, consisting of 
- an bootloader starting a self-written kernel.


## Files
- boot
	- disk.asm
		- contains code to read from disk using BIOS
	- gdt.asm
		- sets up the Global Descriptor Table (GDT) which describes the memory layout for protected-mode
	- initdisp.asm
		- initialized basic display output using BIOS-interrupts while in 16 Bit real mode
	- kernel-entry.asm
		- contains assembler code to hand over to our main function in kernel.c
	- mbr.asm
		- is the main file defining the master boot record (512 byte boot sector)
	- switch-to-32bit.asm
		- contains code to switch from 16 bit real mode to 32 bit protected mode
- drivers
	- ports.c
		- provides low-level access to read/write data from/to hardware-addresses. Used by the vga-driver.
	- ports.h
		- header-file for ports.c
	- vga.c
		- basic vga-driver which enables text-output in 32 bit protected mode
	- vga.h
		- header-file for vga.c
- kernel
	- kernel.c
		- contains the main function of the kernel
	- util.c
		- contains helper functions
	- util.h
		- header-file for util.c
- Makefile
	- wires the compiler, linker, assembler and emulator together so we can boot our operating system
 






