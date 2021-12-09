// a simble thread example
// compile with g++ threadexample.cpp -pthread
#include <iostream>       // std::cout
#include <thread>         // std::thread
 
using namespace std;

void foo() 
{
	for (int i=0;i<500;i++){
		cout << "Foo: " << i << endl;
	}
}

void bar(int x)
{
	for (x=x;x>0; x--){
		cout << "Bar: " << x << endl;
	}
}

int main(int argc, char** argv) 
{
	int y=0;
	if (argc > 1){
		y = atoi(argv[1]); //take second argument from command line
	}

	std::thread first (foo);     // spawn new thread that calls foo()
	std::thread second (bar,y);  // spawn new thread that calls bar(0)

	std::cout << "main, foo and bar now execute concurrently...\n";

	// synchronize threads:
	first.join();                // pauses until first finishes
	second.join();               // pauses until second finishes

	std::cout << "foo and bar completed.\n";

	return 0;
}
