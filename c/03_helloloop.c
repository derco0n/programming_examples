/*
modified hello-world-program, that shows ho to use recursions

This will explain how to use recursions if you have to do the same thing multiple times

Compile under linux using: gcc 03_helloloop.c -o 03_helloloop
*/

#include <stdio.h> // instructs the compiler to implement functionality of the class "stdio.h" which provides functionality for printf();

int main (void){

	int iterations=10;

	puts("First while-loop");
	while (iterations > 0){ //this is a while-loop: it will repeat the content between the brackets until the condition (in this case, as long as iterations is greater 0) isn't met
		puts("Hello"); 
		iterations--; // we have to decrement iterations (iterations = iterations - 1) to be able to end this recursion
	}

	puts("First for-loop");
	for (int counter=10; counter > 0; counter--){ //this is a for-loop which does the same as out while-loop. the difference is, that a for is head-controlled and a while is tail-controlled.
		puts("World");
	}

	//You can count upwards as well
	//Iterations is 0 at this point, as it has been decremented above

	puts("Second while-loop");
	while (iterations < 10){
		puts("Hello");
		iterations++; // we have to increment iterations (iterations = iterations + 1) to be able to end this recursion
	}

	//iterations is now 10
	puts("Second for-loop");
	for (int counter=0; counter < 10; counter++){
		puts("World");
	}

	return 0;  // return value of the main program. 0 signals the operating system, that the program exited normally without errors.
}
