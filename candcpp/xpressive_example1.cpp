#include <iostream>
#include <boost/xpressive/xpressive.hpp>
//#include <boost/xpressive/xpressive_static.hpp>
//#include <boost/xpressive/xpressive_dynamic.hpp>
//#include <boost/xpressive/regex_actions.hpp>

using namespace boost::xpressive;

int main(int argc, char** argv){
  std::string hello("hello world!");

  sregex rex = sregex::compile("(\\w+) (\\w+)!");
  smatch what;

  if(regex_match(hello, what, rex)){
	std::cout << what[0] << "\n"; // whole match
	std::cout << what[1] << "\n"; // first capture
	std::cout << what[2] << '\n'; // second capture
  }

  return 0;
}
