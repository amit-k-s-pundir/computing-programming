#include <tuple>
#include <functional>
#include <string>
#include <iostream>

using namespace std;

template<class... Args> struct ProcessFunctionsList{
  ProcessFunctionsList(Args... args...) : value(tuple<Args...>(args...)){
  }
  typedef tuple<Args...> type;
  tuple<Args...> value;
};

int g1(int){
  cout << "f1 here" << endl;
  return 2;
};

int g2(int, int){
  cout << "f2 here" << endl;
  return 5;
};

typedef tuple<

int main(int argc, char* argv[])
{
  std::function<int(int)> f1(g1);
  std::function<int(int, int)> f2(g2);
  f1(2);
  f2(2, 5);
  tuple<int> t1(2);
  tuple<int, int> t2(2, 5);
  ProcessFunctionsList<tuple<int>, tuple<int, int> >  l(t1, t2);
//  tuple<int> t1(2);
  //tuple<int, int> t2(2, 5);
  f1(get<0>(t1));
  f2(get<0>(t2), get<1>(t2));
  return 0;
}
  
