// compile: g++ ./threadexample2.cpp -lpthread

#include <iostream>
#include <utility>
#include <thread>
#include <chrono>
 
 
struct foo
{
    void bar()
    {
        for (int i = 0; i < 5; ++i) {
            std::cout << "Thread 1 executing\n";
            ++n;
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
        }
    }
    int n = 0;
};
 
class baz
{
public:
    void operator()()
    {
        for (int i = 0; i < 5; ++i) {
            std::cout << "Thread 2 executing\n";
            ++n;
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
        }
    }
    int n = 0;
};
 
int main()
{
    int n = 0;
    foo f;
    baz b;
    std::thread t1(&foo::bar, &f); // t5 runs foo::bar() on object f
    std::thread t2(b); // t6 runs baz::operator() on a copy of object b
    t1.join();
    t2.join();
    std::cout << "Final value of f.n (foo::n) is " << f.n << '\n';
    std::cout << "Final value of b.n (baz::n) is " << b.n << '\n';
	
    return 0;
}
