//This is an extension of the Hello-World example but we are creating an object of a custom class for this
#include "./hello_class.cpp"
#include <stdlib.h>

std::string argument="";

int main (int argc, char *argv[])
{
     if (argc > 1){ // if an commandline argument isgiven...        
        argument = std::string(argv[1]);        // use this as our argument (std::string)
    }
    
    hello_class *myHello = new hello_class(argument); //Initialize a new hello_class-object 
    myHello->printHello(); //Call the printHello()-method of our new object
    
    return 0; //exit program
}