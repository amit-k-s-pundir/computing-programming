#include <stdio.h>
#include <stdlib.h>

enum PriceUnit  {INR, USD, GBP};
enum QuantityUnit {g, kg, ml, l};

typedef struct ShoppingItem{
  const char* itemName;
  enum QuantityUnit qUnit;
  int quantity;
  enum  PriceUnit pUnit;
  int price;
} ShoppingItem;

typedef struct ShoppingListNode{
  struct ShoppingItem* shoppingItem;
  struct ShoppingListNode* next;
  //  ShoppingLIst* prev;
} ShoppingListNode;

typedef struct ShoppingList{
  struct ShoppingListNode* shoppingListNodeFirst;
  struct ShoppingListNode* shoppingListNodeLast;
} ShoppingList;

/* struct ShoppingList* new_shopping_list(struct ShoppingItem* shoppingItem){ */
/*   struct ShoppingListNode* shoppingListNode = malloc(sizeof(struct ShoppingListNode)); */
/*   shoppingListNode->shoppingItem = NULL; */
/*   shoppingListNode->next = NULL; */
/*   //  shoppingList->last = NULL;  */
/*   struct ShoppingList* shoppingList = malloc(sizeof(struct ShoppingList)); */
/*   shoppingList->shoppingListNodeFirst = shoppingListNode; */
/*   shoppingList->shoppingListNodeLast = shoppingListNode; */
/*   return shoppingList; */
/* }; */

ShoppingList* empty_shopping_list(){
  ShoppingList* emptyShoppingList = malloc(sizeof(struct
  ShoppingList));
  ShoppingListNode* shoppingListNode = malloc(sizeof(struct
  ShoppingListNode));
  shoppingListNode->shoppingItem = NULL;
  shoppingListNode->next = NULL;
  emptyShoppingList->shoppingListNodeFirst = shoppingListNode;
  emptyShoppingList->shoppingListNodeLast = shoppingListNode;
  return emptyShoppingList;
};

struct ShoppingList* new_shopping_list(struct ShoppingItem**
shoppingItems){
  if(NULL == shoppingItems) return empty_shopping_list();

  ShoppingList* shoppingList = empty_shopping_list();

  for(int i = 0; i < (sizeof(shoppingItems) /
		      sizeof(shoppingItems[0])); i++){
    add_shopping_item(emptyShoppingList, shoppingItems[i]);
  }

  return shoppingList;
/*    struct ShoppingListNode* shoppingListNode = malloc(sizeof(struct ShoppingListNode));
    shoppingListNode->shoppingItem = shoppingItems[i];
    shoppingListNode->next = NULL;
    shoppingList->last = NULL; */

  /*  struct ShoppingList* shoppingList = malloc(sizeof(struct ShoppingList));
  shoppingList->shoppingListNodeFirst = shoppingListNode;
  shoppingList->shoppingListNodeLast = shoppingListNode;
  return shoppingList;
  */
};

struct ShoppingList* add_shopping_item(struct ShoppingList*
shoppingList, struct ShoppingItem*
shoppingItem){
struct ShoppingListNode* newShoppingListNode = malloc(sizeof(struct
  ShoppingListNode));
  newShoppingListNode->shoppingItem = shoppingItem;
  newShoppingListNode->next = NULL;
  shoppingList->shoppingListNodeLast->next = newShoppingListNode;
  shoppingList->shoppingListNodeLast = newShoppingListNode;
  return shoppingList;
};

struct ShoppingList* new_shopping_list_n(struct ShoppingItem**
					 shoppingItems, int n){
  struct ShoppingList* shoppingList = new_shopping_list(NULL);
  for (int i = 0; i < n; i++){
    add_shopping_item(shoppingList, shoppingItems[i]);
  }
  return shoppingList;
};

struct ShoppingList* n_shopping_list_items(struct ShoppingList* shoppingList, int
n){
  struct ShoppingList* nShoppingList = calloc(n, sizeof(struct
  ShoppingList));
  for(int i = 0; i < n; i++){
    nShoppingList[i] = shoppingList[i];
  }
  return nShoppingList;
};

struct ShoppingList* add_n_items(struct ShoppingList* shoppingList,
				 struct ShoppingItem** shoppingItems,
				 int n){
  for(int i = 0; i < n; i++){
    add_shopping_item(shoppingList, shoppingItems[i]);
  }
  return shoppingList;
}

int main(int argc, char** argv){
  struct ShoppingItem shoppingItems[] = {{"Tea", g, 250, INR, 350},
					 {"Coffee", g, 100, INR, 350}, 
					 {"Green Tea", g, 100, INR,
					  250}, {"Black Pepper", g,
						 100, INR, 200},
					 {"Amul Cheese", g, 100, INR,
					  115}, {"Amul Butter", g,
						 100, INR, 75}, {"Amul Milk", l, 500, INR, 35}};

  struct ShoppingList* shoppingList =
    new_shopping_list_n(shoppingItems, sizeof(shoppingItems));

  //  struct ShoppingItem testShoppingItem = {"Tea", g, 250, INR, 350};
  //  struct ShoppingList* testShoppingList = new_shopping_list(&
  //  testShoppingItem);

  printf("Done\n");
  return 0;
}
