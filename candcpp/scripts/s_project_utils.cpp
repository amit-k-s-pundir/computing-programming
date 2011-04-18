#include <boost/filesystem>

#include <iostream>

using namespace std;
using boost::filesystem;

struct Dir{
        string name;
        vector<path> files;
        vector<path> dirs;
};

void createDir(Dir dir){
        create_directory(dir.name);

        for(vector<path>::iterator it = dir.files.begin(); it != dir.files.end(); ++it){
                touch(*it);
        }

        for(vector<path>::iterator it = dir.dirs.begin(); it != dir.dirs.end(); ++it){
                createDir(*it);
        }
};

path setup_cpp_project(const path & baseDir){
        Dir dir = {{"README"}, {{{}, {"build}}, {}, {}, {}, {}, {}}};


