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

#include <dirent.h>
#include <stdio.h>
#include <sys/types.h>
#include <stddef.h>
int main(int argc, char** argv){

	DIR* dir = opendir("/home/sonu/workspace/");
//	struct dirent* entry;
	struct dirent* result;
	union {
		struct dirent entry;
		char b[offsetof(struct dirent, d_name) + NAME_MAX + 1];
	} u;
	if(NULL != dir){
		while((0 == readdir_r(dir,&u.entry,&result)) && (result != NULL)){
		//	puts(entry->d_name);
		  puts((u.entry).d_name);
		}
		closedir(dir);
	}else{
		perror("Couldn't open the directory");
	}
	return 0;
}
