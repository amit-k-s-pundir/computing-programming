// =====================================================================================
// 
//       Filename:  test1.c
// 
//    Description:  
// 
//        Version:  1.0
//        Created:  Thursday 20 August 2009 02:03:08  IST
//       Revision:  none
//       Compiler:  g++
// 
//         Author:  Amit Pundir (amit_pundir), sonupundir@gmail.com
//        Company:  
// 
// =====================================================================================
#include <stdio.h>
#include <limits.h>
#include <float.h>
#include <stddef.h>
int main(int argc, char** argv){
	struct s {
		int x ;
		int y ;
	} ;
	printf("%d\n", offsetof(struct s, y));
			}
