; Dieses Programm für x86-Prozessoren unter Linux gibt Hello World auf der Kommandozeile aus.
; D. Marx, 09/2019
; Alternative Variante

; assemblieren (32bit) mit:  nasm -f elf ./01_helloworld2.asm
; assemblieren (64bit) mit:  nasm -f elf64 ./01_helloworld2.asm

; anschließend...

; linken mit: 

; #(x86 on x86 / x64 on x64)
;ld -static -o 01_helloworld2 -e start 01_helloworld2.o 

; #(x86-Binary on x64-System)
;ld -m elf_i386 -static -o 01_helloworld2 -e start 01_helloworld2.o 

; Alles in einem Aufruf (32-Bit-Binary auf 64-Bit System):
; nasm -f elf ./01_helloworld2.asm && ld -m elf_i386 -static -o 01_helloworld2 -e start 01_helloworld2.o && ./01_helloworld2



; Zu Beginn (Section .data) passiert gar nichts
; Anschließend (Section .text) werden zur Laufzeit die HEX-Werte der gewünschten ASCII-Zeichen in den Stack geschrieben
; und nach und nach jeweils mit einem Write-Systemcall auf der Kommandozeile ausgegeben.
; Hier ohne eine Schleife bzw. Sprungmarken

section .data


section .text
global start:
start:

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


		; Systemcall zur Textausgabe vorbereiten - Erstes Zeichen		
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Zweites Zeichen	
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Dittes Zeichen	
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...	
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...	
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...	
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...	
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Weiteres Zeichen	...
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		pop eax ; Zuletzt hinzugefügten Wert aus dem Stack holen und in irgendein Register laden (In diesem Fall EAX [es muss irgendwo hin]) - Der Stackpointer wird dadurch wieder um 1 erhöht 
		
		; Systemcall zur Textausgabe vorbereiten - Letztes Zeichen	...	
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden. Der vorherige Wert in EAX (aus dem Stack) wird dabei überschrieben.
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden		
		mov ecx, esp ; Adresse des Stackpointers (Speicheradresse des ersten Zeichens im Stack) in Register ECX schreiben
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])

		
		; Systemcall für Exit (Programmende) vorbereiten
		mov eax, 1 ; Linux Systemcall-Nr. "end" in EAX-Register laden
		mov ebx, 0 ; Returncode "0" (0=normal/no error) in EBX-Register laden
		int 0x80; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])