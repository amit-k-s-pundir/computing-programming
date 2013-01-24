#include <boost/filesystem/fstream.hpp>
#include <vector>
#include <string>
#include <iostream>
#include <fstream>

namespace fs = boost::filesystem;

using namespace std;

int main(int argc, char* argv[]){
        std::vector<string> v({"sonu", "pundir"});

        for(vector<string>::iterator it = v.begin(); it != v.end(); ++it){
                cout << *it << "\n";
        }

        return 0;
}
