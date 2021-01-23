/*
    * Pointer-Examples:
    * This demo-programm will show how pointers are used.
    * a pointer is basically a variable that may contain a memory-address and can be used to indirectly access a value
*/
#include <iostream> 
#include <iomanip>  // This only used for proper hex-formatting. Nothing special here..

// This is a preprocessor instruction defining that the label "SETTO" means 15.
// It won't consume memory and is proccessed at compiletime
#define SETTO 15

using namespace std; 
int main() 
{     
        int a = 5;  //Declare and initialize a variable
        /*
        The following pointer declarations are all valid and they all are doing the same:
        Declaring a new pointer and initializes it with 0 for safety-reasons.
        
        int * b = 0;
        int* b = 0;                
        int *b = 0; // This is how its usually written.
        int *b; // <= this would cause "b" to point to some random address which might be unsafe.
        */
        int *b = 0; // This is how its usually written. Make sure to initialize it with 0 as otherwise it points somewhere random

        cout << "\"b\" is initialized and now pointing to memory-address:  " << b << endl;        
        cout << endl;
        
        //Now make the pointer point to the address of a
        b = &a; //"b" now points to the address of "a"


        cout << "\"a\" is stored at memory-address:  " << &a << endl;
        cout << "\"b\" is stored at memory-address:  " << &b << endl;
        cout << "\"b\" is pointing to memory-address now:  " << b << endl;
        cout << endl;

        cout << "The value of \"a\" is: " << a << endl;  // returns the value of a
        cout << "The value of the area \"b\" is pointing to is: " << *b << endl;  //the "*b" will get the value from the address b points to
        cout << endl;

        //Now modify the value of the address "b" is pointing to...effectively changing the value of "a"       
        cout << "Setting the value of the address \"b\" is pointing to to value: " << SETTO << endl;
        *b=SETTO;
        cout << endl;

        cout << "\"a\" is still stored at memory-address:  " << &a << endl;
        cout << "\"b\" is still stored at memory-address:  " << &b << endl;
        cout << "\"b\" is still pointing to memory-address:  " << b << endl;
        cout << endl;

        cout << "The value of \"a\" is now: " << a << endl;  // returns the value of a
        cout << "The value of the area \"b\" is pointing to is now: " << *b << endl;  //the "*b" will get the value from the address b points to
        cout << endl;


        //Lets examine more memory:
        cout << "Dumping some memory:" << endl;

        //First Decrement the pointer by 10
        b-=10;

        //Now increment the pointer a few times and ...
        cout << "\"b\" points to\t|\tvalue (hex)" << endl;
        for (int c=0; c<20; c++){
            b+=1;

            //...let's have look what data is stored there:
            cout << b << "\t|\t" << "0x" << std::setfill('0') << std::setw(8) << std::hex << *b << endl; //This will only format the values in hex.
        }

        return 0;        
}
