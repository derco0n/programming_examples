; Will display  Hello World on the LCD-Display
; https://www.youtube.com/watch?v=FY3zTUaykVo

PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003


E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000
reset:
  lda #%11111111  ; Set all pins on Port B as OUTPUT
  sta DDRB

  lda #%11100000  ; Set the top three pins on port A as OUTPUT
  sta DDRA

initdsp:
  ; Function set
  lda #%00111000  ; Set 8-Bit mode; 2-line display; 5x8 font
  sta PORTB

  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA

  lda #E ; Set E to send the instruction
  sta PORTA

  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA

  ; Display on/of
  lda #%00001111  ; Display on; cursor on; blink on
  sta PORTB

  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA

  lda #E ; Set E to send the instruction
  sta PORTA

  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA
  
  ; Entrymode
  lda #%00000110  ; Increment and shift cursor; don't shift display
  sta PORTB

  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA

  lda #E ; Set E to send the instruction
  sta PORTA

  lda #0 ; All zeroes, will set all bits for RS/RW/E to zero
  sta PORTA

prtstr:
  lda #"d"  ; Load character
  sta PORTB

  lda #RS ; enable just Register-Select
  sta PORTA

  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA

  lda #RS ; enable just Register-Select
  sta PORTA  

  lda #"e"  ; Load character
  sta PORTB

  lda #RS ; enable just Register-Select
  sta PORTA

  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA

  lda #RS ; enable just Register-Select
  sta PORTA  
  lda #"r"  ; Load character
  sta PORTB

  lda #RS ; enable just Register-Select
  sta PORTA

  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA

  lda #RS ; enable just Register-Select
  sta PORTA  
  lda #"c"  ; Load character
  sta PORTB

  lda #RS ; enable just Register-Select
  sta PORTA

  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA

  lda #RS ; enable just Register-Select
  sta PORTA  
  lda #"o"  ; Load character
  sta PORTB

  lda #RS ; enable just Register-Select
  sta PORTA

  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA

  lda #RS ; enable just Register-Select
  sta PORTA  
  lda #"0"  ; Load character
  sta PORTB

  lda #RS ; enable just Register-Select
  sta PORTA

  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA

  lda #RS ; enable just Register-Select

  sta PORTA  
  lda #"n"  ; Load character
  sta PORTB

  lda #RS ; enable just Register-Select
  sta PORTA

  lda #(RS | E) ; Set E to send the instruction while keeping RS 1 (BOOL OR)
  sta PORTA

  lda #RS ; enable just Register-Select

loop:
  jmp loop

  .org $fffc
  .word reset
  .word $0000

