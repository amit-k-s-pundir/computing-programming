#include <boost/filesystem.hpp>

#include <initializer_list>
#include <iostream>
#include <string>
#include <vector>

#include <stdlib.h>

//using boost::filesystem;

using namespace std;

struct Dir{
        string name;
        vector<string> files;
        vector<Dir> dirs;

        /**
         * Dir(string name, vector<string> files, vector<string> dirs){
         this->name = name;
         this->files = files;
         this->dirs = dirs;
         };
         */
};

bool create_dir(Dir & dir, const string & baseDir){
        string dirName = baseDir + "/" + dir.name;
        string touch_command = "touch";

        boost::filesystem::create_directory(dirName);
        for(vector<string>::iterator it = dir.files.begin(); it != dir.files.end(); ++it){
                const char* command = (touch_command + " " + *it).c_str();
                system(command);
        };

        for(vector<string>::iterator it = dir.dirs.begin(); it != dir.dirs.end(); ++it){
                create_dir(*it, dirName);
        }
};

int main(){
        /**
          typedef struct Dir{
          string name;
          vector<string> files;
          vector<Dir> dirs;
          } Dir;
         **/
        Dir dir {"test_dir", vector<string> {"file1.txt", "file2.txt"}, vector<Dir> {{"test_dir1", vector<string> {"file11.txt", "file22.text"}, vector<Dir> {NULL}}}};

        //        Dir dir{"test_dir", vector<string> {"file1.txt", "file2.txt"}, vector<string> {"test_dir1", "file11.txt", "file22.text" }};

        return 0;
}
