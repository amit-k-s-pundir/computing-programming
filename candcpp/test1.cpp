#include <stdio.h>
#include <iostream>
#include <vector>
#include <string>

using namespace std;

namespace NS1{
  int x =5;
}
using namespace NS1;
int main(int argc, char** argv){
  cout << x << endl;
}

