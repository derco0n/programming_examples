; Dies ist Assemblercode welcher gebootet werden kann.
; Achtung Dieser Code läuft im legacy REALMODE von x86-CPUs
; D. Marx 2019/12

; übersetzen mit:
; nasm -f bin ./00_Hello_Bootloader.asm -o ./00_Hello_Bootloader.img
;
; Anschließend als Diskettenabbild in einer VM mounten oder auf eine Diskette schreiben.


; Dieser Teil...
BITS 16

; BIOS Interupt für Anzeigemodus vorbereiten und ausführen
; Mehr dazu unter: https://de.wikibooks.org/wiki/Interrupts_80x86/_INT_10
;  AH=00h Setze Bildschirmmodus. Das AL-Register enthält die Modusnummer.
;  AL=00h Textmodus, 40 x 25 Zeichen, 16 Graustufen
;  AL=01h Textmodus, 40 x 25 Zeichen, 16 Farben
;  AL=02h Textmodus, 80 x 25 Zeichen, 16 Graustufen
;  AL=03h Textmodus, 80 x 25 Zeichen, 16 Farben
;  AL=04h Grafikmodus, 320 x 200 Pixel, vier Farben
;  AL=05h Grafikmodus, 320 x 200 Pixel, vier Graustufen
;  AL=06h Grafikmodus, 640 x 200 Pixel, Monochrom
;  AL=07h Textmodus, 80 x 25 Zeichen, Monochrom
;  AL=08h reserviert
;  AL=09h reserviert
;  AL=0Ah reserviert
;  AL=0Bh reserviert
;  AL=0Ch reserviert
;  AL=0Dh Grafikmodus, 320 x 200 Pixel, 16 Farben (ab EGA)
;  AL=0Eh Grafikmodus, 640 x 200 Pixel, 16 Farben (ab EGA)
;  AL=0Fh Grafikmodus, 640 x 350 Pixel, Monochrom (nur EGA an MDA-Monitor)
;  AL=10h Grafikmodus, 640 x 350 Pixel, 16 Farben (ab EGA)
;  AL=11h Grafikmodus, 640 x 480 Pixel, Monochrom (ab MCGA)
;  AL=12h Grafikmodus, 640 x 480 Pixel, 16 Farben (ab VGA)
;  AL=13h Grafikmodus, 320 x 200 Pixel, 256 Farben (ab MCGA)
mov al, 0x03 ; Textmodus, 80 x 25 Zeichen, 16 Farben
mov ah, 0x00 ; 0x00 in Register AH schreiben (Bios Interrupt Function Number (10h) 00h = Set Video Mode)
int 0x10 ; BIOS-Interrupt 0x10 (BIOS-Videoservice) ausführen

start:
mov ax, 0x07C0; ; Set up 4K stack space after this bootloader
add ax, 288		; (4096 + 512) / 16 bytes per paragraph

mov ss, ax
mov sp, 4096

mov ax, 0x07C0		; Set data segment to where we're loaded
mov ds, ax

mov si, sometext

mov bl,0  ; initial color attribute

printstr:
; Iteriert Zeichen für Zeichen durch den String

; Farbe setzen (muss für jedes Zeichen geschehen. daher in der Schleife...)
; Register bl mapped in 8-Bits des EBX-Registers (https://www.cs.virginia.edu/~evans/cs216/guides/x86-registers.png)
inc ebx ; EBX hoch interieren um Farben zu wechseln
; Achtung: Wenn beim Farbmodus 0x03 der Wert 15 erreicht ist (Bit 5), wird die Hintergrundfarbe erhöht
; ACHTUNG!: Wenn alle 8 Bits des BL-Registers auf 1 gesetzt sind und anschließend weiter iteriert wird,
; -> wird Register BH iteriert. Nach 16-Bits dann BX...
mov ah, 9 
mov al,0  ;avoding extra characters
int 10h   ;printing colors
;int 21h

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
;mov si, cat
;jmp printstr
jmp rerun

; -------------------------------------------

; Dies definiert einen auszugebenden String
cat db "Hello Bootloader... Dies ist ein sehr langer Text um die Farbiterationen anhand des EBX-Registers zu verdeutlichen. xD ... Bei jedem Zeichen wird die Vordergrundfarbe iteriert. Nach jeweils 16 Zeichen wird die Hintergrundfarbe iteriert. Und irgendwann wird das Blink-Flag (Bit 7?) gesetzt... (Dieser Text ist 328 Zeichen lang.)", 0x00

; Dieser Teil...
times 510 - ($-$$) db 0 ; Pad remainder of boot sector with 0s
dw 0xAA55 ; The standard PC boot signature (2 Bytes)
; ... definiert dass es sich um einen Bootloader handelt. (insgesamt 512 Bytes groß und endet mit 0xAA55)
