#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <algorithm>

#include <string.h>
#include <cctype>
#include <dirent.h>
#include <errno.h>
#include <cstdio>

//namespace fs = boost::filesystem;

using namespace std;
//using namespace fs;

vector<dirent> ls(const char* dirName){
  vector<dirent> v;
  DIR* dir = opendir(dirName);
  dirent entry, *result;
  while(readdir_r(dir, &entry, &result), result){
    v.push_back(entry);
  }
  return v;
};

bool comp(const dirent & d1, const dirent & d2){
  return(string(d1.d_name) < string(d2.d_name));
};

vector<dirent> duplicate_files(const char* dir2, const char* dir1){
  vector<dirent> dirChildren1, dirChildren2, duplicateFiles;
  dirChildren1 = ls(dir1);
  dirChildren2 = ls(dir2);
  sort(dirChildren1.begin(), dirChildren1.end(), comp);
  sort(dirChildren2.begin(), dirChildren2.end(), comp);
  set_intersection(dirChildren1.begin(), dirChildren1.end(),
dirChildren2.begin(), dirChildren2.end(), back_inserter(duplicateFiles), 
comp);
  return duplicateFiles;
//  path p2(dir2), p1(dir1);
 // for(path::iterator it(p2.begin()); it != p2.end(); ++it){
};  

int main(int argc, char* argv[]){
  const char* dir1 = "/opt/.dwhelper/new/";
  const char* dir2 = "/opt/.debian_dwhelper/new/";
  vector<dirent> duplicateFiles = duplicate_files(dir2, dir1);
  vector<dirent>::iterator it;
  cout << "The length is:" << duplicateFiles.size() << endl;
  cout << "These are the duplicate files:" << endl;
  
  for(it = duplicateFiles.begin(); it != duplicateFiles.end(); ++it){
    cout << "The length is:" << duplicateFiles.size() << endl;
    cout << (*it).d_name << endl;
  }
  
  return 0;
}
