; Will display Text on the LCD-Display using function calls
; as the instruction pointer will be written on to the stack during function call, a RAM-module is needed
; The 65C02's datasheet says that it addresses 0x0100 to 0x1ff for the stack and grows downwards
;
; This is based on the work of Ben Eater:;
; https://www.youtube.com/watch?v=ZYJIakkcLYw
;
; Assemble with: vasm6502_oldstyle -Fbin -dotdir ./lcd-test3.s -o ./lcd-test3.bin

PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003


E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000
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

textout:
  ; Print the text out - char by char print:
  ldx #0  ; set the x register to 0
print:
  lda message,x ; load the byte at address of message+x to register A; lda will set the zero-flag if the value loaded was a zero
  beq loop ; if the zero flag is set, we reached the end of the string and should abort the print-loop
  jsr print_char
  inx ; increment x by 1
  jmp print

loop:
  ; endless loop when work is done
  jmp loop

message: .asciiz "github.com/derco0n                      eater.net/6502"  ; From char 40 on the text will displayed in the second line

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

