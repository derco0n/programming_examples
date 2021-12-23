#include <iostream>
#include <string.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <utility>
#include <thread>

using namespace std;

class foo {
    public:
    foo (string wrd, int num){
        this->_wrd=wrd;
        this->_num=num;
    }
    

    void prnt(string tname){
        cout << "Running..." << endl;
        for (int i=0;i<this->_num;i++){
            cout << tname << " -> " << i << ": " << this->_wrd << endl;
        }
    }

    protected:
    string _wrd;
    int _num;
};

int main (void){
    std::vector <std::thread> vecofthreads;  //Vector to store all thread objects

    foo *myfoo = new foo(string("Test"), 100);
    
    std::thread t_storedb1(&foo::prnt, myfoo, string("ONE")); //Create new thread    
    std::thread t_storedb2(&foo::prnt, myfoo, string("TWO")); //Create new thread    
    std::thread t_storedb3(&foo::prnt, myfoo, string("THREE")); //Create new thread
    // Move all three thread objects to vector
    vecofthreads.push_back(std::move(t_storedb1));
    vecofthreads.push_back(std::move(t_storedb2));
    vecofthreads.push_back(std::move(t_storedb3));

    // Iterate over the thread vector
    for (std::thread & th : vecofthreads)
    {
        // If thread Object is Joinable then Join that thread.
        if (th.joinable()) {
            cout << "joining ... " << endl;
            th.join();
        }
           
            
    }
    


    return 0;
}