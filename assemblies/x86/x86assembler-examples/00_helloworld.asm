; Dieses Programm für x86-Prozessoren unter Linux gibt Hello World auf der Kommandozeile aus.
; D. Marx, 09/2019
; Inspiration durch: https://www.youtube.com/watch?v=fYpz5ok80bs

; assemblieren (32bit) mit:  nasm -f elf ./00_helloworld.asm
; assemblieren (64bit) mit:  nasm -f elf64 ./00_helloworld.asm

; anschließend...

; linken mit: 

; #(x86 on x86 / x64 on x64)
;ld -static -o 00_helloworld -e start 00_helloworld.o 

; #(x86-Binary on x64-System)
;ld -m elf_i386 -static -o 00_helloworld -e start 00_helloworld.o 

; Alles in einem Aufruf (32-Bit-Binary auf 64-Bit System):
; nasm -f elf ./00_helloworld.asm && ld -m elf_i386 -static -o 00_helloworld -e start 00_helloworld.o && ./00_helloworld

; Zu Beginn (Section .data) wird der Auszugebende Text und dessen Länge in Bytes in den RAM geladen
; Anschließend (Section .text) werden Zwei Systemcalls (write und exit) vorbereitet und ausgeführt...

; Wird übersetzt zu (Auszug aus 00_helloworld.o):
; ...
; 00000170  B8 04 00 00  00 BB 01 00   00 00 B9 00  00 00 00 BA                                         ................
; 00000180  0D 00 00 00  CD 80 B8 01   00 00 00 BB  00 00 00 00                                         ................
; 00000190  CD 80
; ...

; Auszug: Intel x86 - Opcodes:
; B8 = mov eax <wert>
; BB = mov ebx <wert>
; B9 = mov ecx <wert>
; BA = mov edx <wert>
; CD = INT <Wert>

section .data
		msg db "Hello World!", 0x0a
		; Auszugebener Text (Statische Variable) (Text plus 0x0a [Zeilenumbruch])
		len equ $ - msg ; Vorab (nicht zur Laufzeit) die Länge des Textes berechnen

section .text
global start:
start:

		; Systemcall zur Textausgabe vorbereiten		
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden
		mov ecx, msg ; Pointer der Nachricht (die Start-Speicheradresse der Nachricht) in ECX-Register laden
		mov edx, len ; Länge der Nachricht in EDX-Register laden (Dies sorgt dafür, dass von der Start-Speicheradresse bit zum Ende der Nachricht alle Zeichen ausgegeben werden.)
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		; Systemcall für Exit (Programmende) vorbereiten
		mov eax, 1 ; Linux Systemcall-Nr. "end" in EAX-Register laden
		mov ebx, 0 ; Returncode "0" (0=normal/no error) in EBX-Register laden
		int 0x80; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
