#include <tuple>
#include <functional>
#include <string>
#include <iostream>

using namespace std;

template<T> class withOpenFile{
  std::ofstream o(T::fileName);
};

template<> f : withOpenFile<f>{
  
}


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
  auto i = get<0>(t2);
  cout << i << endl;
  int j = 0;
  cout << tuple_size<decltype(t2)>::value << endl;

  return 0;
}
  
