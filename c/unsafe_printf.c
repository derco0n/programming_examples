/*
unsafe_printf.c
This is very unsafe, as the user has control over the printf-function
supplying a string like "%X %X %X %X %X" will force printf() to reveal the return-address from the stack and breaks ASLR
Avoid doing this whenever possible
*/
#include <stdio.h>

int main(int argc, char **argv) {
   /* print out first command-line argument */
   printf(argv[1]);    //<-- use puts() or similar instead
   printf("\r\n");
   return 0;
}
