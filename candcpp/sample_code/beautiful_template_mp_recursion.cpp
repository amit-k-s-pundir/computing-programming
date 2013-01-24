#include <tuple>
#include <utility> 
#include <iostream>

template<std::size_t I = 0, typename... Tp>
inline typename std::enable_if<I == sizeof...(Tp), void>::type
  print(std::tuple<Tp...>& t)
  { }

template<std::size_t I = 0, typename... Tp>
inline typename std::enable_if<I < sizeof...(Tp), void>::type
  print(std::tuple<Tp...>& t)
  {
    std::cout << std::get<I>(t) << std::endl;
    print<I + 1, Tp...>(t);
  }

int
main()
{
  typedef std::tuple<int, float, double> T;
  T t = std::make_tuple(2, 3.14159F, 2345.678);

  print(t);
}
