#include "dir-utils.h"


using namespace std;
using namespace boost::filesystem;

//template<class R, class... ArgTypes> R with_dir(function<R(ArgTypes...)> f,
//                                                const string & dir){
//}
//template<class R> R with_dir(function<R(const string &)> f, const string & dir){
//        DirUtils dir_utils;
//        dir_utils.pushd(dir);
//        R result = f(dir);
//        dir_utils.popd();
//        return result;
//}

int main()
{
  DirTree dir_tree({"dir_name", {"file1", "file2"}, {NULL}});
  with_dir<bool>([](const string & x){cout << "The string is: " << x << endl;
          return true;}, "dir_name");
//  ensure_dirs_exist(dir_tree);
//  cout << "Hello World!" << endl;
  return 0;
}

