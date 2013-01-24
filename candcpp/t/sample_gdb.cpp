#include <iostream>
#include <string>
#include <dlfcn.h>

//using namespace std;

int main(int argc, char* argv[]){
  dlopen("libncurses.so", RTLD_LAZY);
  std::cout << "Starting a gdb session ..." << "\n";
  return 0;
}
