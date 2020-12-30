; Dieses Programm für x86-Prozessoren unter Linux gibt Hello World auf der Kommandozeile aus.
; D. Marx, 09/2019
; Alternative Variante

; assemblieren (32bit) mit:  nasm -f elf ./05_helloworld6.asm
; assemblieren (64bit) mit:  nasm -f elf64 ./05_helloworld6.asm

; anschließend...

; linken mit: 

; #(x86 on x86 / x64 on x64)
;ld -static -o 05_helloworld6 -e start 05_helloworld6.o 

; #(x86-Binary on x64-System)
;ld -m elf_i386 -static -o 05_helloworld6 -e start 05_helloworld6.o 

; Alles in einem Aufruf (32-Bit-Binary auf 64-Bit System):
; nasm -f elf ./05_helloworld6.asm && ld -m elf_i386 -static -o 05_helloworld6 -e start 05_helloworld6.o && ./05_helloworld6

; Zu Beginn (Section .data) passiert nun gar nichts
; Anschließend (Section .text) wird zur Laufzeit HEAP-Speicher (RAM) mittels Systemcall "brk()" angefordert und die HEX-Werte der gewünschten ASCII-Zeichen in den HEAP geschrieben
; und nach und nach jeweils mit einem Write-Systemcall auf der Kommandozeile ausgegeben.
; Hier als eine Schleife bzw. mit Sprungmarken - Die Ausgabe auf der Kommandozeile erfolgt nun durch eine separate Funktion "aufkonsoleschreiben"
; http://x86asm.net/articles/memory-allocation-in-linux/

; brk() ist in der Praxis nicht zu empfehlen, da das verschiedene Nachteile hat:
;	Freigeben von RAM ist nicht ohne weiteres möglich...
;	Speicher lässt sich nur am Stück benutzen...
; Dies ist daher nur zur Veranschaulichung gedacht.
; In der Praxis sollten andere Methoden der HEAP-Alloziierung verwendet werden - z.B. malloc() aus der C-stdlib

section .data


section .text
; Funktionen
heapspeicheriterieren: ; Eine Funktion um die im HEAP gespeicherten Daten zu iterieren
	; ruft auch "aufkonsoleschreiben" auf
	
	;Um innerhalb der Funktion auf die Parameter zugreifen zu können, wird üblicherweise der Basepointer ebp zu Hilfe genommen.
	;Wenn er gleich zu Anfang der Funktion gesichert und dann mit dem Wert des Stackpointers belegt wird, 
	;kann der erste Parameter immer über [ebp+8] und der zweite Parameter über [ebp+12] erreicht werden, 
	;unabhängig davon, wieviele push- und pop-Operationen seit Beginn der Funktion verwendet wurden.
	push ebp
	mov  ebp,esp
	
	mov ecx,[ebp+8]    ; 1. Parameter in in Register ECX schreiben: ESI-(HEAP-)Basisadresse
    mov eax,[ebp+12]   ; 2. Parameter in EBX-Register laden:	HEAP-Endadresse
	;
	push ebx
	push eax ; Endadresse des HEAP sichern
	
	
	; Iterationschleife
	schleife: ; sprungmarke "schleife" - Hierhin springen wir -solange die schleife läuft- immer wieder zurück...
	
		
		
		; FUNKTION zur Textausgabe mit Parametern vorbereiten und aufrufen:
		push 1 ; 2. Parameter für Funktion (Auf Konsole schreiben [1=write to console]) 
		push ecx ; 1. Parameter für Funktion (Auf Konsole schreiben [HEAP-Adresse des auzugebenden Zeichens])
		call aufkonsoleschreiben ;	Funktion zur Textausgabe aufrufen:
		add esp,8    ; Parameter wieder vom Stack entfernen
		
		; Gesicherte Start und Endadressen aus dem Stack holen (Umgekehrte Reihenfolge wie gepspeichert (LIFO)
		pop eax ; Die gesichterte Endadresse des HEAP aus dem Stack lesen und in Register EAX schreiben
		pop ebx ; Die gesichterte Aktuelle Adresse des HEAP aus dem Stack lesen und in Register EAX schreiben
		add ebx,1 ; Den Wert von ESI um 1 erhöhen... somit durch den HEAP iterieren	
		
		
		; Auf Abbruchbedingung prüfen		
		cmp:
		cmp ebx, eax ; Prüfen ob dies die letzte Adresse des HEAP ist (Aktuelle Adresse in ESI, Endadresse in EAX)
		jg nachschleife ; Falls vorherige Prüfung zutrifft (jg = JUMP Greeater), aus der Schleife "ausbrechen" 
		;- JG weil am Ende der Schleife esi erst um 1 erhöht wird und bei JE sonst das letzte Zeichen abgeschnitten werden würde
		
		; Dies passiert nur wenn die Abbruchbedingung nicht erfüllt ist:
		push ebx
		push eax ; Die Endadresse des HEAP wieder im Stack sichern, da eax bei der nächsten Iteration wieder überschrieben wird.
		loop schleife ; wieder zur Sprungmarke "schleife" springen. - Ohne Abbruchbedingung passiert dies Endlos!!!! 
		; - Was dazu führt, dass immer weitere Speicherzellen ausgelesen werden und der Prozess irgendwann vom Betriebssystem mit einem Speicherzugriffsfehler beendet wird.
		; Deshalb muss innerhalb der Schleife unbedingt eine Abbruchbedingung vorhanden sein

	nachschleife: ; Sprungmarke "nachschleife" Hierhin soll zum ausbrechen aus der Schleife gesprungen werden, wenn die Abbruchbedingung erfüllt ist...
	
	pop ebp
	
	ret ; return

aufkonsoleschreiben: ; eine Funktion zur Textausgabe auf der Konsole

	;Um innerhalb der Funktion auf die Parameter zugreifen zu können, wird üblicherweise der Basepointer ebp zu Hilfe genommen.
	;Wenn er gleich zu Anfang der Funktion gesichert und dann mit dem Wert des Stackpointers belegt wird, 
	;kann der erste Parameter immer über [ebp+8] und der zweite Parameter über [ebp+12] erreicht werden, 
	;unabhängig davon, wieviele push- und pop-Operationen seit Beginn der Funktion verwendet wurden.
	push ebp
	mov  ebp,esp
	
	mov ecx,[ebp+8]    ; 1. Parameter in in Register ECX schreiben. (Adresse des auszugebenden Zeichens [vom HEAP])
    mov ebx,[ebp+12]   ; 2. Parameter in EBX-Register laden	(Where to write, 1=screen)
	
	; Systemcall zur Textausgabe vorbereiten		
		;mov ecx, esi ; Adresse des auszugebenden Zeichens (vom HEAP) in Register ECX schreiben.
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden		
		;mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden	
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
	
	pop ebp
	
	ret ; return
	

; -- MAIN:
global start:
start:

		;brk(addr)    [Linux Syscall: 45]
        ;brk(addr) accepts one argument: addr
        ;If addr is zero, brk() returns the 
        ;current beginning of the heap. 
        ;Otherwise, it sets the end of the 
        ;heap to addr.
		
		
		;Bytes_To_Allocate = 8
		;Heap_Beginning = brk(0)
		;brk(Heap_Beginning + Bytes_To_Allocate)
		;// we now have 8 bytes of space on the heap! Wooo
		
		; Source: https://seisvelas.github.io/journal/journal/asm-heap/

		
		; Systemcall zur Vergrößerung des HEAP-Speichers vorbereiten
		mov eax, 45 ; Linux Systemcall-Nr. 45 "brk()" in EAX-Register laden
		mov ebx, 0 ; 0: Argument für brk() setzen
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		; EAX-Register enthält nun die Statadresse des HEAP-Speichers
		mov esi, eax ; HEAP-Startadresse in ESI-Register sichern
			
		
		; Systemcall zur Vergrößerung des HEAP-Speichers erneut vorbereiten
		mov eax, 45 ; Linux Systemcall-Nr. 45 "brk()" in EAX-Register laden
		mov ebx, esi ; HEAP-Startadresse als Argument für brk() setzen
		add ebx, 13 ; 13 auf den Wert des EBX-Registers addieren.
		
		; Der HEAP-Speicher wird hierdurch nach Ausführung des Systemcall um die entsprechende Anzahl Bytes vergrößert.
		int 0x80 ;  vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel]). HEAP-SPeicher wird vergrößert...
		
		; ESI enthält nun die HEAP-Startaddresse
        ; und dem HEAP wurden 13 Bytes zugewiesen
		; EBX enthält die HEAP-Endadresse
		;push ebx ; Die Endadresse des HEAP im Stack sichern
        
		;Die gewünschten Zeichen in den HEAP schreiben
		 mov byte [esi+0], 0x48 ; H
		 mov byte [esi+1], 0x65 ; e
		 mov byte [esi+3], 0x6c ; l
		 mov byte [esi+4], 0x6c ; l
		 mov byte [esi+5], 0x6f ; o
		 mov byte [esi+6], 0x20 ; Whitepace
		 mov byte [esi+7], 0x57 ; W
		 mov byte [esi+8], 0x6f ; o
		 mov byte [esi+9], 0x72 ; r
		 mov byte [esi+10], 0x6c ; l
		 mov byte [esi+11], 0x64 ; d
		 mov byte [esi+12], 0x21 ; !
		 mov byte [esi+13], 0x0a ; Linefeed
    
		; FUNKTION zur HEAP-Iteration mit Parametern vorbereiten und aufrufen:
		push ebx ; 2. Parameter für Funktion - Die Endadresse des HEAP im Stack sichern
		push esi ; 1. Parameter für Funktion - ESI-Basis(-start-)adresse
		call heapspeicheriterieren ;	Funktion HEAP-Iteration aufrufen:
		add esp,8    ; Parameter wieder vom Stack entfernen
		
		
		; Systemcall für Exit (Programmende) vorbereiten
		mov eax, 1 ; Linux Systemcall-Nr. "end" in EAX-Register laden
		mov ebx, 0 ; Returncode "0" (0=normal/no error) in EBX-Register laden
		int 0x80; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])