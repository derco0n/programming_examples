/*
standard hello-world-program

Compile under linux using: gcc 01_hellworld.c -o 01_helloworld
*/

#include <stdio.h> // instructs the compiler to implement functionality of the class "stdio.h" which provides functionality for printf();

int main (void){
	printf("Hello world\r\n");  //print out Hello world followed by a linebreak(\r\n)
	return 0;  // return value of the main program. 0 signals the operating system, that the program exited normally without errors.
}
