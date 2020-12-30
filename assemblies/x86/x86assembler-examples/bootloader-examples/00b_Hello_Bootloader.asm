; Dies ist Assemblercode welcher gebootet werden kann.
; Achtung Dieser Code läuft im legacy REALMODE von x86-CPUs
; D. Marx 2019/12

; übersetzen mit:
; nasm -f bin ./00_Hello_Bootloader.asm -o ./00_Hello_Bootloader.img
;
; Anschließend als Diskettenabbild in einer VM mounten oder auf eine Diskette schreiben.


; Dieser Teil...
BITS 16

start:
mov ax, 0x07C0; ; Set up 4K stack space after this bootloader
add ax, 288		; (4096 + 512) / 16 bytes per paragraph

mov ss, ax
mov sp, 4096

mov ax, 0x07C0		; Set data segment to where we're loaded
mov ds, ax

mov si, sometext

printstr:
; Iteriert Zeichen für Zeichen durch den String
lodsb ; For legacy mode, Load 1-byte at address DS:(E)SI into AL. For 64-bit mode load byte at address (R)SI into AL.
cmp al,0 ; Prüft ob das im Register AL befindliche Zeichen ein NULL-Byte ist (Stringende).
jz hang ; Jump-Zero: Wenn vorherige Prüfung True ist (Inhalt von AL=0), dann zur Sprungmarke Hang springen

; BIOS Interupt vorbereiten und ausführen
; Mehr dazu unter: https://en.wikipedia.org/wiki/BIOS_interrupt_call
mov ah, 0x0e ; 0x0e in Register AH schreiben (Bios Interrupt Function Number (10h) 0Eh = Write Character in TTY Mode)
int 10h ; BIOS-Interrupt ausführen
jmp printstr ; Wieder zum Anfang von printstr springen


; Diese Funktion stellt eine Endlosschleife dar, 
; welche entsprechend viele CPU-Befehle ausführt und einen Core voll auslastet.
hang:
jmp hang

; -------------------------------------------

; Dies definiert einen auszugebenden String
sometext db "Hello Bootloader...", 0

; Dieser Teil...
times 510 - ($-$$) db 0 ; Pad remainder of boot sector with 0s
dw 0xAA55 ; The standard PC boot signature (2 Bytes)
; ... definiert dass es sich um einen Bootloader handelt. (insgesamt 512 Bytes groß und endet mit 0xAA55)
