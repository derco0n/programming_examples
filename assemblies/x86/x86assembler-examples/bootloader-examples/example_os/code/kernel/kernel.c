/*
This is example-os's main kernel.

Although leaving the 16 bit real mode means we will not have the BIOS at our disposal anymore and we need to 
write our own I/O drivers, we now have the ability to write code in a higher order language like C!
This means we do not have to rely on assembly language anymore.

*/

#include "../drivers/vga.h"
#include "util.h"

void main() {
	/*
	char* video_memory = (char*) 0xb8000; //Get a pointer to the beginning of the video-memory in VGA-Mode
	*video_memory = 'D'; // put an D in there
	*/
	clear_screen();
	print_string("Welcome to Example OS v0.1\n");
	print_nl();
	while (true){
		// Main loop: Do stuff in here...
	}

}
