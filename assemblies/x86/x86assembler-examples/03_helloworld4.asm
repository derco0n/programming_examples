; Dieses Programm für x86-Prozessoren unter Linux gibt Hello World auf der Kommandozeile aus.
; D. Marx, 09/2019
; Alternative Variante

; assemblieren (32bit) mit:  nasm -f elf ./03_helloworld4.asm
; assemblieren (64bit) mit:  nasm -f elf64 ./03_helloworld4.asm

; anschließend...

; linken mit: 

; #(x86 on x86 / x64 on x64)
;ld -static -o 03_helloworld4 -e start 03_helloworld4.o 

; #(x86-Binary on x64-System)
;ld -m elf_i386 -static -o 03_helloworld4 -e start 03_helloworld4.o 

; Alles in einem Aufruf (32-Bit-Binary auf 64-Bit System):
; nasm -f elf ./03_helloworld4.asm && ld -m elf_i386 -static -o 03_helloworld4 -e start 03_helloworld4.o && ./03_helloworld4

; Zu Beginn (Section .data) passiert nun gar nichts
; Anschließend (Section .text) wird zur Laufzeit HEAP-Speicher (RAM) mittels Systemcall "brk()" angefordert und die HEX-Werte der gewünschten ASCII-Zeichen in den HEAP geschrieben
; und nach und nach jeweils mit einem Write-Systemcall auf der Kommandozeile ausgegeben.
; Hier als eine Schleife bzw. mit Sprungmarken
; http://x86asm.net/articles/memory-allocation-in-linux/

; brk() ist in der Praxis nicht zu empfehlen, da das verschiedene Nachteile hat:
;	Freigeben von RAM ist nicht ohne weiteres möglich...
;	Speicher lässt sich nur am Stück benutzen...
; Dies ist daher nur zur Veranschaulichung gedacht.
; In der Praxis sollten andere Methoden der HEAP-Alloziierung verwendet werden - z.B. malloc() aus der C-stdlib

section .data


section .text
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
		push ebx ; Die Endadresse des HEAP im Stack sichern
        
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
    
		
		schleife: ; sprungmarke "schleife" - Hierhin springen wir -solange die schleife läuft- immer wieder zurück...
		; Systemcall zur Textausgabe vorbereiten		
		mov ecx, esi ; Adresse des auszugebenden Zeichens (vom HEAP) in Register ECX schreiben.
		mov eax, 4 ; Linux Systemcall-Nr. "write to console" in EAX-Register laden		
		mov ebx, 1 ; 1 (Where to write, 1=screen) in EBX-Register laden	
		mov edx, 1 ; Länge  in EDX-Register laden 
		int 0x80 ; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])
		
		add esi,0x1 ; Den Wert von ESI um 1 erhöhen... somit durch den HEAP iterieren
		
		pop eax ; Die gesichterte Endadresse des HEAP aus dem Stack lesen und in Register EAX schreiben
		
		; Auf Abbruchbedingung prüfen		
		cmp esi, eax ; Prüfen ob dies die letzte Adresse des HEAP ist (Aktuelle Adresse in ESI, Endadresse in EAX)
		jg nachschleife ; Falls vorherige Prüfung zutrifft (jg = JUMP Greeater), aus der Schleife "ausbrechen" 
		;- JG weil am Ende der Schleife esi erst um 1 erhöht wird und bei JE sonst das letzte Zeichen abgeschnitten werden würde
		
		; Dies passiert nur wenn die Abbruchbedingung nicht erfüllt ist:
		push eax ; Die Endadresse des HEAP wieder im Stack sichern, da eax bei der nächsten Iteration wieder überschrieben wird.
		loop schleife ; wieder zur Sprungmarke "schleife" springen. - Ohne Abbruchbedingung passiert dies Endlos!!!! 
		; - Was dazu führt, dass immer weitere Speicherzellen ausgelesen werden und der Prozess irgendwann vom Betriebssystem mit einem Speicherzugriffsfehler beendet wird.
		; Deshalb muss innerhalb der Schleife unbedingt eine Abbruchbedingung vorhanden sein

		nachschleife: ; Sprungmarke "nachschleife" Hierhin soll zum ausbrechen aus der Schleife gesprungen werden, wenn die Abbruchbedingung erfüllt ist...
		
		; Systemcall für Exit (Programmende) vorbereiten
		mov eax, 1 ; Linux Systemcall-Nr. "end" in EAX-Register laden
		mov ebx, 0 ; Returncode "0" (0=normal/no error) in EBX-Register laden
		int 0x80; vorbereiteten Systemcall ausführen (Interrupt 0x80 [call linux-kernel])