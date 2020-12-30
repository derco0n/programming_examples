#include "./hello_class.cpp"

class hello_class_extended : public hello_class {

private:

public:
    hello_class_extended(std::string name):hello_class(name) { //Dervied constructor which calls the base's constructor
        
    }


void printGoodBye() //Print-hello-Method
    {
        std::cout << "Good Bye World";  //Print out Hello world
        
        if (this->_name.compare("") != 0){
            //name is intialized with somethin different than ""
             std::cout << ": " << this->_name; //output the first arguments

        }
        std::cout <<  "\r\n"; //output a new line        
    }

};