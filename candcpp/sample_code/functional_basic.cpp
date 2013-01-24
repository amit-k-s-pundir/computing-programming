#include <vector>
#include <functional>
#include <iostream>
#include <string>

using namespace std;

struct F{
    template<class R, class... Args> F(std::function<R(Args... args)>& f){
    a = new  apply<R(Args...)>(f);
  }
  
  template<class R, class... Args>  struct apply{
    apply(std::function<R(Args... args)> f) : f(f){
    }
    R operator()(Args... args){
      f(args...);
    }
    std::function<R(Args... args)> f;
  };
  void* a;
};

int f1(int){
  cout << "hello" << endl;
  return 1;
};

int main(int argc, char* argv[]){
  std::function<int(int)> f(f1);
  F::apply<int, int> a(f);
  a(5);
  F* f1 = new F(f);
  f1->a->operator()(2);
  return 0;
}
