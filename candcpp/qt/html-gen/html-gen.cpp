#include "html-gen.h"
#include <string>
#include <iostream>
#include <vector>
#include <fstream>
#include <map>
#include <initializer_list>


using namespace std;


HtmlGen::HtmlGen()
{
}

namespace HTML{
template <class... Children> class Element{
        public:
        Element(Children... children);
        map<string, string> attributes;

}
