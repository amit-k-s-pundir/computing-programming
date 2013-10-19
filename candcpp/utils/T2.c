#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

typedef void* (*Fn)(char* arg1, ...);
void* f(char* arg1, char* arg2){
  printf("%s\n%s\n", arg1, arg2);
}

void* testFn(Fn fn, int argc, ...){
  char* argv[argc];
  va_list ap;
  va_start(ap, argc);
  char *arg1, *arg2;
  arg1 = va_arg(ap, char*);
  arg2 = va_arg(ap, char*);
  fn(arg1, arg2);
  return (void*)NULL;
}

typedef void* (*F1)(void* args);
//typedef void* (*getArg)(void* args);

void* f1(void* args){
  const char* arg1 = *((const char**)args);
  args = args + sizeof(char**);
  int arg2 = *((int*)args);
  args++;
  printf("Saying %s, %d times!", arg1, arg2);
  return NULL;
}

void* testFn1(F1 f1, void* args){
  return f1(args);
};

int main(int argc, char** argv){
  testFn(f, 2, "hello", "there");
  struct Args {
    char *arg1;
    int i;
  } *pArgs;
  pArgs = malloc(sizeof (struct Args ));
  printf("Size of struct Args: %d", sizeof(struct Args));
  pArgs->arg1 = strdup("hello");
  pArgs->i = 2;
    
  testFn1(f1, pArgs);
  return 0;
}
  