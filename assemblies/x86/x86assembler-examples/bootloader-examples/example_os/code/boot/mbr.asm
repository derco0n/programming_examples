; The main assembly file for the boot loader contains the definition of the master boot record, as well as include statements for all relevant helper modules.

[bits 16] ; running in 16 Bit real-mode. Not switching to 32 Bit protected-mode here
[org 0x7c00] ; in NASM this set the assembler location counter, specifying where the BIOS should load the bootloader to

; where to load the kernel to
KERNEL_OFFSET equ 0x1000 ; defines an assembler contannt. later the kernel will be loaded to this address

; BIOS sets boot drive in 'dl'; store for later use
mov [BOOT_DRIVE], dl

; setup stack
mov bp, 0x9000 ; set the stack's-basepointer to 0x9000
mov sp, bp ; set the stack-pointer to it's current base-address

call initdisp ; initializes the displaymode and cleares the display

; print welcome messages
mov si, dinited
call printstr;

mov si, bootloader
call printstr;

call load_kernel ; calls the function that loads the kernel
call switch_to_32bit ;calls the function the switches to 32 BIT protected mode

jmp $

%include "boot/initdisp.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/switch-to-32bit.asm"

[bits 16]
load_kernel:
    ; loads the kernel from disk to RAM (specified address)
    mov bx, KERNEL_OFFSET ; bx -> destination (where to put the data)
    mov dh, 16             ; dh -> num sectors (how many sectors need to be read from disk)
    mov dl, [BOOT_DRIVE]  ; dl -> disk (from which drive should we load the data)
    call disk_load ; calls the function that reads data from disk using the arguments specified above
    ret

[bits 32]
BEGIN_32BIT:
    ; executes the instruction which are present in RAM at the offset to which the kernel-data had been written to
    call KERNEL_OFFSET ; give control to the kernel
    jmp $ ; loop in case kernel returns

; boot drive variable
BOOT_DRIVE db 0

; Some Strings (including CR/LF and an completing NULL-Byte)
bootloader db "Example-OS bootloader starting...", 0x0D, 0xA, 0x00
dinited db "Basic display output initialized...", 0x0D, 0xA, 0x00


; In order to generate a valid master boot record, we need to include some padding
; by filling up the remaining space with 0 bytes times 510 - ($-$$) db 0 and the magic number dw 0xaa55

; padding
times 510 - ($-$$) db 0 

; magic number
dw 0xaa55
