; Dieses Programm für x86-Prozessoren unter Linux gibt Hello World auf der Kommandozeile aus.
; D. Marx, 09/2019
; Alternative Variante

; assemblieren (32bit) mit:  nasm -f elf ./02_helloworld3.asm
; assemblieren (64bit) mit:  nasm -f elf64 ./02_helloworld3.asm

; anschließend...

; linken mit: 

; #(x86 on x86 / x64 on x64)
;ld -static -o 02_helloworld3 -e start 02_helloworld3.o 

; #(x86-Binary on x64-System)
;ld -m elf_i386 -static -o 02_helloworld3 -e start 02_helloworld3.o 

; Alles in einem Aufruf (32-Bit-Binary auf 64-Bit System):
; nasm -f elf ./02_helloworld3.asm && ld -m elf_i386 -static -o 02_helloworld3 -e start 02_helloworld3.o && ./02_helloworld3

; Zu Beginn (Section .data) passiert nun gar nichts
; Anschließend (Section .text) werden zur Laufzeit die HEX-Werte der gewünschten ASCII-Zeichen in den Stack geschrieben
; und nach und nach jeweils mit einem Write-Systemcall auf der Kommandozeile ausgegeben.
; Hier als eine Schleife bzw. mit Sprungmarken

section .data


section .text
global start:
start:

		mov ebx, esp ; Zu Beginn die Basisadresse des Stackpointers wegsichern...

		; Bytes (ASCII) in den Stack (First in, Last Out) schreiben...
		; Der Stack beginnt am Ende des Programms (Hohe Speicheradresse) und zählt mit jedem neuen Eintrag 1 herunter (Richtung niedrigerer Speicheradressen)
		push 0x0a ; Linefeed	; Stackpointer - 1
		push 0x21 ; !			; Stackpointer - 1
		push 0x64 ; d			; Stackpointer - 1
		push 0x6c ; l			; ...
		push 0x72 ; r
		push 0x6f ; o
		push 0x57 ; W
		push 0x20 ; Whitepace
		push 0x6f ; o
		push 0x6c ; l
		push 0x6c ; l
		push 0x65 ; e
		push 0x48 ; H

		schleife: ; sprungmarke "schleife" - Hierhin springen wir -solange die schleife läuft- immer wieder zurück...

		; Systemcall zur Textausgabe vorbereiten - Erstes Zeichen
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben.-
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden		
		push ebx 	; WICHTIG: Den aktuellen Inhalt des Registers EBX (Die ESP-Basisadresse) in den Stack schreiben um diesen zwischenzuspeichern. EBX wird gleich für den Systemcall überschrieben!
					;- Der Stackpointer wird dadurch erneut um 1 verringert
					; In der Adresse des Stackpointers ist nun die initiale Basisadresse des Stackpointers zwischengesichert.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden	
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop ebx ; WICHTIG: Die Zwischengespeicherte, initiale Basisadresse des Stackpointers wieder zurück in Register EBX laden. - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Auf Abbruchbedingung prüfen
		cmp esp, ebx ; Prüfen ob der Stackpointer wieder bei seiner Startposition angekommen ist.
		je nachschleife ; Falls vorherige Prüfung zutrifft (je = JUMP EQUAL), aus der Schleife "ausbrechen"
		
		loop schleife ; wieder zur Sprungmarke "schleife" springen. - Ohne Abbruchbedingung passiert dies Endlos!!!! 
		; - Was dazu führt, dass immer weitere Speicherzellen ausgelesen werden und der Prozess irgendwann vom Betriebssystem mit einem Speicherzugriffsfehler beendet wird.
		; Deshalb muss innerhalb der Schleife unbedingt eine Abbruchbedingung vorhanden sein

		nachschleife: ; Sprungmarke "nachschleife" Hierhin soll zum ausbrechen aus der Schleife gesprungen werden, wenn die Abbruchbedingung erfüllt ist...
		
		; Systemcall für Exit (Programmende) vorbereiten
		mov eax, 1 ; Linux Systemcall-Nr. "end" in EAX-Register laden
		mov ebx, 0 ; Returncode "0" (0=normal/no error) in EBX-Register laden
		int 0x80; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])