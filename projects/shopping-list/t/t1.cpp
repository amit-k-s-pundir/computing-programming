#include <vector>
#include <iostream>
#include <string>

using namespace std;

extern "C" {
  void print_string(char* s){
    string s1(s);
    cout << s1 << endl;
  }
}
