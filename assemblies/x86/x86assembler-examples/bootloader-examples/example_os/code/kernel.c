/*
This is example-os's main kernel.

Although leaving the 16 bit real mode means we will not have the BIOS at our disposal anymore and we need to 
write our own I/O drivers, we now have the ability to write code in a higher order language like C!
This means we do not have to rely on assembly language anymore.

For now the task of the kernel will be to output the letter D in the top left corner of the screen.
To do that we will have to modify video memory directly. 
For color displays with VGA text mode enabled the memory begins at 0xb8000.

Each character consists of 2 bytes: The first byte represents the ASCII encoded character, 
the second byte contains color information. 
Below is a simple main function inside kernel.c that prints an D in the top left corner of our screen.

*/

void main() {
	char* video_memory = (char*) 0xb8000; //Get a pointer to the beginning of the video-memory in VGA-Mode
	*video_memory = 'D'; // put an X in there
}
