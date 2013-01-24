#include <vector>
#include <string>
#include <initializer_list>
#include <iostream>

#include <sonu/FileUtils.hpp>

using namespace std;
//template<class Root, class... Children> class DirTree{};
//template<class Root, template<class... Args> class... Children>  class DirTree{};


struct Project{
  Project(const char* name, const char* baseDir, const DirTree& dirTree) : name(name),
                                                                               baseDir(baseDir),
                                                                               dirTree(dirTree){
  };
  void setUp(){
    // withDir(baseDir,
    //         createDirTree(project.dirs)
    pushd(baseDir);
    createDirTree(dirTree);
    popd;
  };
  const string& name;
  const path& baseDir;
  const DirTree& dirTree;
};

int main(int argc, char* argv[]){

  return 0;
}
