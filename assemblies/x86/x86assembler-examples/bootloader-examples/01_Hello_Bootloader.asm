; Dies ist Assemblercode welcher gebootet werden kann.
; Achtung Dieser Code läuft im legacy REALMODE von x86-CPUs
; D. Marx 2019/12

; übersetzen mit:
; nasm -f bin ./00_Hello_Bootloader.asm -o ./00_Hello_Bootloader.img
;
; Anschließend als Diskettenabbild in einer VM mounten oder auf eine Diskette schreiben.


; Dieser Teil...
[BITS 16]
[ORG 0x7C00]
;--------------

mov si, cat

printstr:
; Iteriert Zeichen für Zeichen durch den String
lodsb ; For legacy mode, Load 1-byte at address DS:(E)SI into AL. For 64-bit mode load byte at address (R)SI into AL.
cmp al,0x00 ; Prüft ob das im Register AL befindliche Zeichen ein NULL-Byte ist.
jz rerun ; Jump-Zero: Wenn vorherige Prüfung True ist (Inhalt von AL=0), dann zur Sprungmarke rerun springen

; BIOS Interupt vorbereiten und ausführen
; Mehr dazu unter: https://en.wikipedia.org/wiki/BIOS_interrupt_call
mov ah, 0x0e ; 0x0e in Register AH schreiben (Bios Interrupt Function Number (10h) 0Eh = Write Character in TTY Mode)
int 0x10 ; BIOS-Interrupt ausführen
jmp printstr ; Wieder zum Anfang von printstr springen


; Diese Funktion setzt den String erneut und ruft printstr anschließend erneut auf.
rerun:
mov si, cat
jmp printstr


; -------------------------------------------

; Dies definiert einen auszugebenden String
cat db "Hello Bootloader...", 0x00

; ... und dieser Teil...
times 510 - ($-$$) db 0
dw 0xAA55
; ... definieren dass es sich um einen Bootloader handelt.
