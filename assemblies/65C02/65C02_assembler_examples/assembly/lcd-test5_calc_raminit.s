; Will display Text on the LCD-Display using function calls
; as the instruction pointer will be written on to the stack during function call, a RAM-module is needed
; The 65C02's datasheet says that it addresses 0x0100 to 0x1ff for the stack and grows downwards
; this extension to the previous version will add a convert-subroutine to get decimal numbers from internal values
; This is basically the same as lcd-test4 but will zero out the whole RAM on startup
;
; logical memory map:
; 0x0000 - 0x3FFF - RAM
; 	-> 0x0100 - 0x01FF - STACK
; 0x6000 - 0x60F - IO CHIP
; 0x8000 - 0xFFFF - ROM
; 	-> 0xFFFC - 0xFFFD - RESET VECTOR
;	-> 0xFFFE - 0xFFFF - IRQ / BRK VECTOR
;	-> 0xFFFA - 0xFFFB - NMI VECTOR
;	-> 0xFFF8 - 0xFFF9 - ABORT VECTOR
;	-> 0xFFF4 - 0xFFF5 - COP VECTOR
;	See more about interrupts here: https://en.wikipedia.org/wiki/Interrupts_in_65xx_processors 
;
; This is based on the work of Ben Eater:;
; https://www.youtube.com/watch?v=ZYJIakkcLYw
; https://www.youtube.com/watch?v=v3-a-zqKfgA
;
; Assemble with: vasm6502_oldstyle -Fbin -dotdir ./lcd-test5_calc_raminit.s -o ./lcd-test5.bin

; defining a few symbols
PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

RAMPAGEPTR = $0000
RAMMINPAGE =  $00
RAMMAXPAGE =  $3f

value = $0200  ;two bytes
mod10 = $0202  ;two bytes
resultstring = $0204 ;6 Bytes (2^16 => 5 digits + NULL-Terminator)

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

number: .word 6502 ; The number we want to convert to digits

resetram:
  ; as RAM stays powered when resetting the CPU it will keep its contents
  ; this will reset the whole RAM-address space by iterate all possible 8-Bit sized pages
  ; and the iterating all addresses within a page
  ; and then setting them to zero
	;Absolute Indexed
	;This addressing mode makes the target address by adding the contents of the X or Y 
	;register to an absolute address. 
	;For example, this 6502 code can be used to fill 10 bytes with $FF starting at address $1009, 
	;counting down to address $1000.  
	;
	; LDA #$FF    
	; LDY #$09    
   	;loop:    
   	; STA $1000,Y ; absolute indexed addressing    
   	; DEY    
   	; BPL loop   

  ldx #$00 ; X = outer loop counter
outerclearloop:
   ; increment X by 1. at first run wthis will also ensure that we won't write anything to the first page
   ; which we can't do as we are saving out pointer there.
  inx

  txa ; transfers the content of X to A
  sta RAMPAGEPTR ; Stores the contents of A in RAMPAGEPTR
  ldy #$FF ; reset Y = inner loop counter
innerclearloop:
  lda #$00
  sta (RAMPAGEPTR),y ; stores the value in A to the address crafted from the values in RAMPAGEPTR and Y
  dey
  bpl innerclearloop ; 	Branch on PLus jump back to innerclearloop as long th value in dey is positive
  ; once y goes negative w go here
  cpx RAMMAXPAGE ; check if we have reached the last page
  bne outerclearloop ; if this was not the last page jump back to outer loop
  lda #$00
  ldy #$FF
clearfirstpage:
  sta $0000,y ; stores the value in A to the address crafted from the values in $0000 and Y
  dey
  bpl clearfirstpage ;  Branch on PLus jump back to clearfirstpage as long th value in dey is positive
  ; once y goes negative w go here, all memory addresses should have been set to zero now.

reset:
  ; initialize the stackpointer to begin at 0x1ff instead of somwhere in the given range
  ldx #$ff  ; load 0xff to the X-Register;  A2 FF
  txs ; transfer the value of the x-Register to the stack-pointer ; 9A

  ; configure the 65C22-IO-Chip
  lda #%11111111  ; Set all pins on Port B as OUTPUT ; A9 FF
  sta DDRB ; 8D 02 60

  lda #%11100000  ; Set the top three pins on port A as OUTPUT; A9 E0
  sta DDRA ; 8D 03 60

initdsp:
  ; initializes the lcd module

  ; Function set
  lda #%00111000  ; Set 8-Bit mode; 2-line display; 5x8 font ; A9 38
  jsr lcd_instruction  ; jsr will put the next instruction-address on to the stack and then jumps to the address of the subroutine ; 20 3C 80

  ; Display on/of
  lda #%00001111  ; Display on; cursor on; blink on ; A9 0F
  jsr lcd_instruction  ; jsr will put the next instruction-address on to the stack and then jumps to the address of the subroutine ; 20 3c 80

  ; Entrymode
  lda #%00000110  ; Increment and shift cursor; don't shift display
  jsr lcd_instruction  ; jsr will put the next instruction-address on to the stack and then jumps to the address of the subroutine

  ; Clear the screen
  lda #%00000001  ; Clear the Display; A9 01
  jsr lcd_instruction  ; jsr will put the next instruction-address on to the stack and then jumps to the address of the subroutine


convert:
  ; will do a convert (https://www.youtube.com/watch?v=v3-a-zqKfgA)

  ; initialize the output string
  lda #0 ; load zero to register A
  sta resultstring ; Storing the 0 at the first byte of out string resulting in an empty string

  ; initalize value to be the number to convert
  lda number ; Load the first byte of the number into the a register
  sta value ; and store it in ram at location (value)
  lda number + 1 ; Load the second byte of the number into the A register
  sta value + 1 ; and store it in ram at location (value+1)

divide:
  ; initalize the remainder (mod10) with zeroes
  lda #0
  sta mod10 ; first byte
  sta mod10 + 1 ; second byte

  ldx #16  ; load 16(decimal)-resulting from the bitness- to the X-register. we have to decrement this in a loop. 
  clc ; Clear the CPU's carry-bit to intialize it
divloop:
  ; rotate the quotient (value) to the left
  rol value
  rol value + 1 ; carry bit of the left half of value will go into the right half of mod10
  
  ; rotate remainder (mod10) to the left
  rol mod10 ; carry bit will go to the left half of mod10
  rol mod10 + 1

  ; subtracting dividend - divisor ( Register A and Y  will contain the result afterwards)
  sec ; intialize the carry-bit of the CPU
  lda mod10 ; load the low byte of the remainder(mod10) to the A register
  sbc #10 ; subtract (with carry) 10(decimal)from the value in register A
  tay ; save the low byte in register Y (Transfer A to Y)
  lda mod10 + 1 ; load the high byte of the remainder(mod10) to the A register
  sbc #0 ; subtract (with carry) 0(decimal)from the value in register A
  ; A and Y are now containing the result
  
  ; Check if the carry flag has been set...
  bcc ignore_result ; branch if carry clear (dividend < divisor)
  ; carry flag has been set. we need to write back the result
  sty mod10 ; store the contents of the Y-register to the low byte of mod10
  sta mod10 + 1 ; store the contents of the A-register to the high byte of mod10

ignore_result:
  dex  ; substract register X by 1. if it gets 0 the CPU's Zero-Flag willbe set
  bne divloop ; if X-register is not 0 (Zero-Flag is not set) jump back to divloop
  ; we need to do one last rotation if the loop is finished
  rol value; shift in the last bit of the quotient
  rol value + 1

  ; output the current digit as a character
  lda mod10
  clc
  adc #"0"
  jsr push_char ; add the current charater to the resultstring

  ; if the division is not done we need to continue dividing
  ; if value != 0, then continue
  ; performing a bitwise or of all bits (lower and upper half) of value
  ; if they all are 0, we are done
  lda value
  ora value + 1
  bne divide; branch to "divide" if value i not zero
  
  ; we are done
  jmp textout

push_char:
  ; Adds a character to the resulting string
  ; Will add the character in the A register to the beginning of the NULL-terminated string
  pha ; Push the contents of register A to the stack
  ldy #0 ; index

char_loop:
  lda resultstring,y  ; Get char from "resultstring" at index of the value in the Y-register
  tax  ; ...and put into X-register
  pla ; pull the saved value from the stack back to register A
  sta resultstring,y ; save the value in register a to "resultstring"at index of the value in the Y-register
  
  iny ; increment index
  
  txa ; transfer the content of the X-register to the A-register
  pha ; push the new contents of the A-register to the stack

  bne char_loop  ; if the end is not reached, continue
  
  ; finalize the string with its NULL-Byte
  pla  ; pull the NULL-byte from the stack
  sta resultstring,y  ; ...and put it at the end of out string
  
  ; We're done here and have to return to the calling subroutine
  rts  ; return from subroutine


textout:
  ; Print the text out - char by char print:
  ldx #0  ; set the x register to 0
print:
  lda resultstring,x ; load the byte at address of message+x to register A; lda will set the zero-flag if the value loaded was a zero
  beq loop ; if the zero flag is set, we reached the end of the string and should abort the print-loop
  jsr print_char
  inx ; increment x by 1
  jmp print


loop:
  ; endless loop when work is done
  jmp loop

lcd_wait:
  ; Waits for the LCD to become ready by checking the busy flag
  pha  ; put the value which is in register A on to the stack ; not needed in this case as after this function the value of register A is irrelevant
  lda #%00000000  ; Set all pins on Port B as INPUT ; A9 00
  sta DDRB ; 8D 02 60
lcd_busy:  
  lda #RW
  sta PORTA
  lda #(RW | E)
  sta PORTA
  lda PORTB  ; Read Flags from LCD (Port B from IO-CHIP)
  and #%10000000  ; do a bool AND to filter out the bit (Busy-Flag) we're interested in; the and-instruction will update the zero-flag which is like doing a cmp-instruction
  bne lcd_busy  ; branch if not equal (while the zero-flag is not set)

  ; clear the enable-bit again
  lda #RW
  sta PORTA
  lda #%11111111  ; Set all pins on Port B as OUTPUT ; A9 FF
  sta DDRB ; 8D 02 60
  pla  ; pull the value which was stored on the stack back to register A; only needed if a value was stored on the stack beforehand
  rts


lcd_instruction:
  ; sends an instruction to the lcd-module
  jsr lcd_wait
  pha  ; put the value which is in register A on to the stack ; not needed in this case as after this function the value of register A is irrelevant
  sta PORTB
  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA
  lda #E ; Set E to send the instruction
  sta PORTA
  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA
  pla  ; pull the value which was stored on the stack back to register A; only needed if a value was stored on the stack beforehand
  rts  ; rts will pull the return address from the stack and then jumps to that address

print_char:
  ; prints a character on the lcd-module
  jsr lcd_wait
  pha  ; put the value which is in register A on to the stack ; not needed in this case as after this function the value of register A is irrelevant
  sta PORTB
  lda #RS ; enable just Register-Select
  sta PORTA
  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA
  lda #RS ; enable just Register-Select
  sta PORTA
  pla  ; pull the value which was stored on the stack back to register A; only needed if a value was stored on the stack beforehand
  rts  ; rts will pull the return address from the stack and then jumps to that address

  .org $fffc
  .word reset
  .word $0000

