; Dieses Programm für x86-Prozessoren unter Linux gibt Hello World auf der Kommandozeile aus.
; D. Marx, 09/2019
; Inspiration durch: https://www.youtube.com/watch?v=fYpz5ok80bs

; assemblieren (32bit) mit:  nasm -f elf ./06_nop.asm
; assemblieren (64bit) mit:  nasm -f elf64 ./06_nop.asm

; anschließend...

; linken mit: 

; #(x86 on x86 / x64 on x64)
;ld -static -o 06_nop -e start 06_nop.o 

; #(x86-Binary on x64-System)
;ld -m elf_i386 -static -o 06_nop -e start 06_nop.o 

; Alles in einem Aufruf (32-Bit-Binary auf 64-Bit System):
; nasm -f elf ./06_nop.asm && ld -m elf_i386 -static -o 06_nop -e start 06_nop.o && ./06_nop

; Zu Beginn (Section .data) wird der Auszugebende Text und dessen Länge in Bytes in den RAM geladen
; Anschließend (Section .text) werden Zwei Systemcalls (write und exit) vorbereitet und ausgeführt...

section .data
		msg db "Hello World!", 0x0a
		; Auszugebener Text (Statische Variable) (Text plus 0x0a [Zeilenumbruch])
		len equ $ - msg ; Vorab (nicht zur Laufzeit) die Länge des Textes berechnen

section .text
global start:
start:

		; This is a NoP-Sled like its often used for exploits...
		
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun
		nop ; No Operation. Nichts tun

	
		


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
