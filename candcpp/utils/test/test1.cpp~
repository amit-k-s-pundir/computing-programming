#include <algorithm>
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

#include <dirent.h>

using namespace std;

DIR* dir = opendir("/opt/.debian_dwhelper/new");
dirent entry, *result;

bool comp(const dirent & d1, const dirent & d2){
  return (string(d1.d_name) < string(d2.d_name));
};

int main(){
  string s1("abcd"), s2("efgh");
  //cout << comp(s1, s2) << endl;
  
  vector<dirent> dirChildren;
  readdir_r(dir, &entry, &result);
  while(result){
 //   cout << entry.d_name << endl;
    dirChildren.push_back(entry);
    readdir_r(dir, &entry, &result);
  }
  sort(dirChildren.begin(), dirChildren.end(), comp);
  vector<dirent>::iterator it;
  for(it = dirChildren.begin(); it != dirChildren.end(); ++it){
    cout << (*it).d_name << endl;
  }
  
  return 0;
}