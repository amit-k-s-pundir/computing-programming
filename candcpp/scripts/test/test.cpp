#include <iostream>
#include <string>

#include "boost/filesystem.hpp"

namespace fs = boost::filesystem;
using namespace std;
using namespace fs;

int main(){
        fs::create_directory(fs::path("/home/sonu/workspace/programming/candcplusplus/test/temp1"));
}
