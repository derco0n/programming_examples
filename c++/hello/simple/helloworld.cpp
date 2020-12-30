//This is demonstration of a simple hello world
#include <iostream>

int main (int argc, char *argv[])
{
    std::cout << "Hello World";  //Print out Hello world
    
    if (argc > 1){ // if an commandline argument isgiven...
        std::cout << ": " << argv[1]; //output the first arguments
    }
    std::cout <<  "\r\n"; //output a new line
    
    return 0; //exit program
}