# A simple Hello-World-Example in ARM Assembly (using Linux-Systemcalls)
# This simple example is pretty much the same as on x86 as it is using Linux-Systemcalls
# Compile with "as ./01_hello_world.asm -o ./01_hello_world.o && ld ./01_hello_world.o -o ./01_hello_world.bin"

.text            
.global _start
_start:
    # Move 1 in Register 0 (1 = Write to screen- on x86 EBX would be used)
    mov r0, #1

    #LDR Rd,=label can load any 32-bit numeric value into a register.
    #It also accepts PC-relative expressions such as labels, and labels with offsets.
    
    # Store the starting address of message in Register 1 - on x86 this would go to ECX
    ldr r1, =message
    # Store the length of message in Register 2 - on x86 this would go to EDX
    ldr r2, =len
    
    #Move 4 in Register 7 (4 = Linux Systemcall for "Write to console" - on x86 EAX would be used)
    mov r7, #4
    
    #Execute Software-Interrupt 0 - on x86 this would be int 0x80
    swi 0

    #Move 1 in Register 7; on x86 EAX would be used again
    mov r7, #1

    #Execute Software-Interrupt 0 - on x86 this would be int 0x80 again
    swi 0

.data
message:
    .asciz "Hello World in ARM-Assembly!\n"
# len is the length of the messagestring above
len = .-message
