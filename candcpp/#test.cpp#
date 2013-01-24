// =====================================================================================
// 
//       Filename:  test.cpp
// 
//    Description:  
// 
//        Version:  1.0
//        Created:  Wednesday 19 August 2009 07:50:46  IST
//       Revision:  none
//       Compiler:  g++
// 
//         Author:  Amit Pundir (amit_pundir), sonupundir@gmail.com
//        Company:  
// 
// =====================================================================================

#include "dirent.h"
#include <stdio.h>
#include <sys/types.h>
#include <iostream>
#include <vector>
#include <string>

int main(int argc, char** argv){
  using namespace std;

  vector<string> v();
  v.push_
  
  DIR* dir = opendir("/usr_gentoo/");
  struct dirent* entry;
  struct dirent** result;
  if(NULL != dir){
	while(entry = readdir_r(dir,entry,result)){
	  puts(entry->d_name);
	}
  }else{
	perror("Couldn't open the directory");
  }
}
