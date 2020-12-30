#include <iostream>
#include <stdlib.h>

class hello_class {

    private:
    //Private objects and methods

    protected:
    //Protected object that can be inherited by child objects
    std::string _name="";

    public:
    //Public objects and methods
    hello_class() { //Default-Constructor

    }  

    hello_class(std::string name){
        this->_name=name;
    }

    void printHello() //Print-hello-Method
    {
        std::cout << "Hello World";  //Print out Hello world
        
        if (this->_name.compare("") != 0){
            //name is intialized with somethin different than ""
             std::cout << ": " << this->_name; //output the first arguments

        }
        std::cout <<  "\r\n"; //output a new line        
    }


};