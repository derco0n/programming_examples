/*
This will demonstrate what happens if a variable is passed to a function vs
a variable-reference is passed to function.

*/
#include <iostream>
#include <stdlib.h>
using namespace std;

void al(int g) //treats the passed variable as a local variable
{ // Note that "g" will exist as a new "g" within the function's-scope
    cout << "Local var: " << endl;
    g++;
    cout << g << endl;
}

void ar(int &g)  //Uses the variable by reference
{ // Note that we're manipulation the original g here, as we're using a reference to the memoryaddress of "g"
    cout << "Referenced var: " << endl;
    g++;
    cout << g << endl;
}

int main()
{
    int g = 100;
    
    cout << "Initial value: " << g << endl;
    al(g); //Will pass the g to the function which will create a new local variable from that

    cout << "After al(): " << g << endl;

    cout << endl << "####################" << endl;

    // Now by reference
    ar(g); //Will pass the "main"-g-reference to the function...
    cout << "After ar(): " << g << endl;

    return 0;
}
