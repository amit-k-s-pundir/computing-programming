#include <boost/program_options.hpp>
#include <boost/program_options/parsers.hpp>
namespace po = boost::program_options;

using namespace boost;
using namespace boost::program_options;

#include <iostream>
#include <string>
#include <initializer_list>
#include <map>

using namespace std;
const map<string,string>& default_attrs = map<string,string>({{"first","sonu"},{"second","pundir"}});
class Test{
private:
  const map<string,string>& attrs;// = map<string,string>({{"first","sonu"},
  //		{"sirname","pundir"}});//(default_attrs);

public:
  Test(const map<string,string>& attrs1 = default_attrs):attrs(attrs1){
	//		attrs = attrs1;
  }
};

int main(int argc, char* argv[]){
  map<string,string> m({{"first","pundir"},{"last","sonu"}});
  Test test(m);
  map<string,int> anim = {{"bear", 4}, {"cassowary", 2}};
  map<string,string> attrs { {"first","sonu"}, {"second","pundir"} };
 return 0;
}

