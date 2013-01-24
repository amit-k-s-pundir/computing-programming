#include <iostream>
#include <string>
#include <vector>
#include <initializer_list>
#include <tuple>
#include <fstream>
#include <functional>
#include <boost/filesystem.hpp>

#include "dir-utils.h"

using namespace std;

bool ensure_dirs(vector<Dirtree> dirs){
        for(Dirtree dir : dirs){
            ensure_dirtree(dir);
          }
        return true;
}

bool ensure_dirtree(const Dirtree & dirtree){
        create_directories(dirtree.dir_name);
        for(string s : dirtree.files){
           ofstream of(s, ios_base::out);
           of << endl;
           of.close();
          }
        return true;
};


/*template<class R> R with_dir(function<R(const string &)> f, const string & dir){
        DirUtils dir_utils;
        dir_utils.pushd(dir);
        R result = f(dir);
        dir_utils.popd();
        return result;
}*/;
