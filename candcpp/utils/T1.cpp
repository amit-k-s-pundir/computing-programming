#include <vector>
#include <functional>

using namespace std;

struct F{
  template<class R, class... Args>  struct Apply{
    Apply(std::function<R(Args... args)> f) : f(f){
    }
    R operator()(Args... args){
      f(args...);
    }
    std::function<R(Args... args)> f;
  };
};

int main(int argc, char* argv[]){
  return 0;
  }
