; This will initialize Display with a specific bios-mode and provides a funtion to write a string

[bits 16] ; still running in 16 Bit real-mode.

; https://de.wikibooks.org/wiki/Interrupts_80x86/_INT_10
initdisp:
;initializes the display
pusha
mov al, 0x03 ; Textmode, 80 x 25 chars, 16 colors
mov ah, 0x00 ; write 0x00 to register AH (Bios Interrupt Function Number (10h) 00h = Set Video Mode)
int 0x10; call interrupt (BIOS-Videoservice)
popa
ret

printstr:
; prints a string
pusha
prtloop:
lodsb ; Load 1-byte at address DS:(E)SI into AL.
cmp al,0x00 ; check if al is zero (end of string)
jz finprt ; exit function if zero
; if al is not 0 prepare bios-interrupt to write character on screen
mov ah, 0x0e
int 0x10; call bios interrupt
jmp prtloop
finprt:
popa
ret
