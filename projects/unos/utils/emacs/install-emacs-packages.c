#include <stdlib.h>
#include <socket.h>

#define with_dir(dir, code) 

#define MAX_EMACS_PACKAGES 10000

typedef struct EmacsPackageProps EmacsPackageProps;

typedef struct EmacsPackage{
  typedef void* (*installFn) (void*);
  EmacsPackageProps* props;
}EmacsPackage;

struct EmacsPackageProps{
  const char* packageName;
  const char* downloadURL;
  const char* downloadDir;
  const char* packageInstallDir;
  const char* dotEmacsCode;
};
  
EmacsPackage emacsPackagesInstallationTable[MAX_EMACS_PACKAGES];


void install_emacs_packages(void** emacsPackages){
}

void install_emacs_helm(const char* gitURL, const char* downloadDir,
			const char* installDir){
  
}

typedef struct List{
  void* pHead = 0;
  void* pTail = 0;
} List;

void* append(void* pElt, void* pList){
  pList->pTail->pNext = pElt;
  pList->pTail = pElt;
  return pList;
};

void* push(void* pElt, void* pList){
  pElt->pNext = plist->pHead;
  pList->pHead = pElt;
  return pList;
};

void print_list(List* pList, void (*f) (void*)){
  void* t = pList->pHead;
  while(t->node){
    f(t->node);
    t = t->next;
    if(!t) return;
  }
}



typedef void* *p_install_fn(void*);

typedef struct {
  const char const * name;
  typedef void (*F)(void);
} package;

typedef struct package_table {
  struct package* pkg;
  struct package_table* next
} package_table;

void install_packages(package** packages, int len){
  for(int i = 0; i < len, i++){
    install_package(package[i]);
  }
};

void install_package(package* ppackage){


int main(){


   return 0;
}
