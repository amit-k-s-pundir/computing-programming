#ifndef DIRUTILS_H
#define DIRUTILS_H

#include "dir-utils_global.h"

#include <iostream>
#include <initializer_list>
#include <string>
#include <vector>
#include <tuple>
#include <fstream>
#include <boost/filesystem.hpp>
#include <functional>

using namespace std;
using namespace boost::filesystem;

struct Dirtree{
/*  DirTree(tuple<string, vector<string>, vector<DirTree*> > dir_tree){
    dir_name = get<0>(dir_tree);
    files = get<1>(dir_tree);
    dirs = get<2>(dir_tree);
  }*/
  Dirtree(string dir_name, vector<string> files, vector<DirTree*> dirs)
    : dir_name(dir_name), files(files), dirs(dirs){
  }
  string dir_name;
  vector<string> files;
  vector<Dirtree*> dirs;
};

bool ensure_dirtree(Dirtree dirtree){
        return true;
}

bool ensure_dirs_exist(const Dirtree & dirtree);

struct DirUtils{
        vector<path> dir_stack;

        path  pushd(const string & dir){
          path current_dir = current_path();
          dir_stack.push_back(current_dir);
          current_path(dir);
          return current_path();
        };

        path popd(){
                path next_dir = dir_stack.back();
                current_path(next_dir);
                return current_path();
        };
};

//extern template<class R> R with_dir(function<R(const string &)> f, const string & dir);
template<class R> R with_dir(function<R(const string & dir, const string &)> f){
        DirUtils dir_utils;
        dir_utils.pushd(dir);
        R result = f(dir);
        dir_utils.popd();
        return result;
};


#endif // DIRUTILS_H
