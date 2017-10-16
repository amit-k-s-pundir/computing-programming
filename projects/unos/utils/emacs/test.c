#include <stdio.h>

typedef struct ListCell{
  void* car = 0;
  void* cdr = 0;
} ListCell;

typedef struct Cons{
  void* car;
  void* cdr;
};

void* cons(void* car, void* cdr){
  struct Cons* cons = (struct Cons*) malloc(sizeof(struct Cons));
  cons->car = car;
  cons->cdr = cdr;
  return cons;
};

void* list(void* elem){
  cons(elem, null);
};

void* list(void** elems, size_t n){
  void* ls;
  for(int i = 0; i < n; i++){
    ls = append(ls, ls(elems[i]));
  }
  return ls;
}

typedef struct List{
  ListCell* listCell;  
  void* pHead = listCell;
  void* pTail = listCell;
} List;

void* append(void* pElt, void* pList){
  if(pList->pTail){
    pList->pTail->pNext = pElt;
  }
  pList->pTail = pElt;
  return pList;
};

void* push(void* pElt, void* pList){
  if(pList->pHead){
    pElt->pNext = plist->pHead;)
    
    pList->pHead = pElt;
    return pList;
};

void* list(void* pNode){
  List ls;
  if(!pHead){
    pHead = pNode;
  }

  if(!pTail){
    pTail = pNode;
  }

void print_list(List* pList, void (*f) (void*)){
  void* t = pList->pHead;
  while(t->node){
    f(t->node);
    t = t->next;
    if(!t) return;
  }
}
