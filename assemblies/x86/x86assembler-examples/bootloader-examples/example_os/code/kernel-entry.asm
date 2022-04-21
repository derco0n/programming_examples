; this will run the kernel-code

; It is important to remember that the kernel-entry.asm
; is not included into our mbr.asm but will be placed at the front of the kernel binary using our Makefile

[bits 32]
; define an external procedure which is not defined in the assembly-code. Linker has to resolve the address
[extern main]

; call the external procedure
call main
jmp $
