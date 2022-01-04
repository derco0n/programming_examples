// compile: g++ ./threadexample5.cpp -lpthread

#include <iostream>
#include <thread>
#include <vector>
 
using namespace std;

class foo
{
    
    public:
    foo(int items){
        for (int counter=0;counter < items; counter++){
            this->_values.push_back(counter);
        }

    }

    void dostuff(){  // Will create three threads wich will run the class' own worker-method
        cout << "Running" << endl;
        std::thread t1(&foo::worker, *this, 5);
        std::thread t2(&foo::worker, *this, 3);
        std::thread t3(&foo::worker, *this, 0);
        t1.join();
        t2.join();
        t3.join();
        cout << "Done" << endl;
    }
    
    
    private:
    std::vector <int> _values;

    void worker(int start=0)
    { // Will process class internal data in a seperate thread   
        for (const auto& val : this->_values)        
        {  
            if (val > start) {
                std::cout << start << ": " << val << endl;            
            }
        }     
    } 


};
 
int main()
{
    foo *myfoo = new foo(10); //Create a new instance of foo
    myfoo->dostuff(); // call the dostuff()-method of the foo-instance
    return 0;
}
