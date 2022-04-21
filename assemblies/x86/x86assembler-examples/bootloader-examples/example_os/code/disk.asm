; this will load data from the disk

; Reading from disk is rather easy when working in 16 bit mode, as we can utilize BIOS functionality 
; by sending interrupts. Without the help of the BIOS we would have to interface with the I/O devices 
; such as hard disks or floppy drives directly, making our boot loader way more complex.

; In order to read data from disk, we need to specify where to start reading, 
; how much to read, and where to store the data in memory. 
; We can then send an interrupt signal (int 0x13) and the BIOS will do its work, reading the following 
; parameters from the respective registers:

; ah 	Mode (0x02 = read from disk)
; al 	Number of sectors to read
; ch 	Cylinder
; cl 	Sector
; dh 	Head
; dl 	Drive
; es:bx 	Memory address to load into (buffer address pointer)


disk_load:
    ; uses bios-interrupt to load data from disk

    ; First thing every procedure should do is to push all general purpose registers (ax, bx, cx, dx) 
    ; to the stack using pusha so we can pop them back before returning in order to avoid side effects of the 
    ; procedure.
    ; Additionally we are pushing the number of sectors to read (which is stored in the high part of 
    ; the the dx register) to the stack because we need to set dh to the head number before 
    ; sending the BIOS interrupt signal and we want to compare the expected number of sectors read
    ; to the actual one reported by BIOS to detect errors when we are done.
    pusha
    push dx

    ; Setup the required paramters
    mov ah, 0x02 ; read mode
    mov al, dh   ; read dh number of sectors
    mov cl, 0x02 ; start from sector 2
                 ; (as sector 1 is our boot sector)
    mov ch, 0x00 ; cylinder 0
    mov dh, 0x00 ; head 0

    ; dl = drive number is set as input to disk_load
    ; es:bx = buffer pointer is set as input as well

    int 0x13      ; BIOS interrupt
    jc disk_error ; check carry bit for error (jump if carry-bit is set will be set on error)

    pop dx     ; get back original number of sectors to read
    cmp al, dh ; BIOS sets 'al' to the # of sectors actually read
               ; compare it to 'dh' and error out if they are !=
    jne sectors_error ; (jump if unequal. different number of sectors as indicated had been read)
    
    popa ; restore the original values of the general-purpose-register from the stack
    ret

disk_error:
    ; Todo: Print out an error message instead of just looping
    mov si, errord
    call printstr;
    jmp disk_loop

sectors_error:
    ; Todo: Print out an error message instead of just looping
    mov si, errors
    call printstr;
    jmp disk_loop

disk_loop:
    jmp $

; Some Strings (including CR/LF and an completing NULL-Byte)
errord db "Disk error: Unable to read from Disk!", 0x0D, 0xA, 0x00
errors db "Disk error: Unable to read all sectors!", 0x0D, 0xA, 0x00

