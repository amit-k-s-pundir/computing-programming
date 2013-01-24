#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cstdarg>

#include <unistd.h>
#include <stdlib.h>


using namespace std;
//using namespace boost;

int main(int argc, char* argv[]){
  vector<string> v({"one", "two", "three", "four", "five"});
  for(int i = 0; i < v.size(); ++i){
    cout << v[i] << endl;
    }
  return 0;
}
