#include <iostream>

using namespace std;

template<class R, class A> R testFn(A a){
  cout << a << endl;
};
int main(int argc, char* argv[]){
  testFn<int, int>(5);
  return 0;
}
