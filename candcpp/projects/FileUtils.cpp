#include <string>
#include <vector>
#include <initializer_list>

#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>

using namespace std;

vector<const char*> dirStack;

void pushd(const char* newDir){
  dirStack.push_back(getcwd(NULL, 0));
  chdir(newDir);
};

int popd(){
const char* dir = dirStack.back();
dirStack.pop_back();
 chdir(dir);
};

struct DirTree{
  typedef vector<const char*> Files;
  typedef vector<DirTree> Dirs;
  DirTree(const char* name, const Files& files, const Dirs& dirs) : name(name), files(files), dirs(dirs){};
  DirTree(const char* name, const initializer_list<const char*>& files,
          const initializer_list<DirTree>& dirs) : name(name), files(files), dirs(dirs){};
  bool create(const char* baseDir = getcwd(NULL, 0)){
    if(baseDir){pushd(baseDir);};
    mkdir(name, 0777);
    pushd(name);
    for(auto it = files.begin(); it != files.end(); ++it){
      string fileName = *it;
      string command = string("touch ") + fileName;
      system(command.c_str());
    };
    for(auto it = dirs.begin(); it != dirs.end(); ++it){
      (*it).create();
    };
  };

  const char* name;
  //  enum fileType {directory, file};f
  Files files;
  Dirs dirs;
};

template<class R, class... Args> auto withDir(const char* newDir, function<R(Args... args)> f, Args... args){
  pushd(newDir);
  auto r = f(args...);
  popd();
};

int main(){
  vector<string> files = {"file1", "file2"};
  vector<DirTree> dirs = {DirTree("Dir1", {"file21", "file22"}, {}), DirTree("Dir2", {"file23", "file24"}, {})};
  DirTree dirTree("TestDir", {"file1", "file2"}, dirs);
  dirTree.create();
  return 0;
}

