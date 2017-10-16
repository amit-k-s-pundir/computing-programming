#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>

int main(){
  /*
  printf("%d\n", sizeof(char));
  printf("\n");
  */

  char* s = "sbcl.tar.gz2";
  char* p = strrchr(s, '.');
  //  if(p) printf("%s\n", p);
  if(!strcasecmp(p, ".bz2")) {
    printf("%s\n", "found it!");
  } else {printf("%s\n", "didn't find!");};

   char* s1 = strdup(s);
  const char* delimiter = ".";
  const char* token;

  while(token = strtok(s1, delimiter)){
    printf("%s\n", token);
  };
  
  
  return 0;
}
