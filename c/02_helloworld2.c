/*
modified hello-world-program

Compile under linux using: gcc 02_hellworld.c -o 02_helloworld
*/

#include <stdio.h> // instructs the compiler to implement functionality of the class "stdio.h" which provides functionality for printf();

int main (void){
	// There are multiple ways to achieve the same thing.
	printf("Hello");  //print out Hello. <- Note, that print() is an old function which, if used wrong, can lead to vulnerabilities in software...
	puts(" World"); //will put out the string " World" followed by a linebreak (this function will automatically append a linebreak). <- Note that puts() does a similar thing as printf(), but using puts() is considered safer.
	return 0;  // return value of the main program. 0 signals the operating system, that the program exited normally without errors.
}
