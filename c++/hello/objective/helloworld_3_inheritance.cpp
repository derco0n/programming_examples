//This is an extension of the Hello-World example but we are creating an object of an inherited class of our custom class for this
#include "./hello_class_extended.cpp"
#include <stdlib.h>

std::string argument="";

int main (int argc, char *argv[])
{
     if (argc > 1){ // if an commandline argument isgiven...        
        argument = std::string(argv[1]);        // use this as our argument (std::string)
    }
    
    hello_class_extended *myextendedHello = new hello_class_extended(argument); //Initialize a new hello_class_extended-object 
    myextendedHello->printHello(); //Call the printHello()-method of our new object, as this one has all methods from the parent's object
    myextendedHello->printGoodBye(); //Call the printGoodBye()-method of our new object, as this one has the new method builtin.
    
    return 0; //exit program
}