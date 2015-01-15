#include <iostream>
#include <sstream>
#include <vector>
#include <string>

#include <pqxx/pqxx>

using namespace std;
//using namespace pqxx;

string s;


extern "C"{

  using namespace std;
  using namespace pqxx;
  
  struct ShoppingList, ShoppingItem;
  typedef int UserId, ShoppingItemId;
  
  ShoppingList get_shopping_list(UserId userId);
  void add_shopping_item(ShoppingList* shoppingList, ShoppingItem* shoppingItem);
  void add_item(ShoppingList* shoppingList, ShoppingItemId*
		shoppingItemId);
  void remove_item(ShoppingList* shoppingList, ShoppingItemId*
		   shoppingItemId);
  ShoppingItem get_item(ShoppingItemId* id);
  //  ItemList list_items();

  ShoppingList get_shopping_list(UserId userId){
    string query = "select * from ShoppingList";
    work w(conn);
    result r(w.exec(query));
    string  name;
    string brand;
    double quantity;
    boolean purchased;
    string fromWhere;
    string note;
    date byWhen;
    date whenPurchased;
    double expectedPrice;
    double realPrice;
    string suggestedShop;
    string actualShop;
    vector<ShoppingItem> shoppingList;
    for(auto it = r.begin(); it != r.end(); ++it){
      ShoppingItem shoppingItem(it("ShoppingItemId").to(shoppingItemId),
				it("quantity").to(quantity), it("fromWhere").to(fromWhere),
				it("whenPurchased").to(whenPurchased),
				it("expectedPrice").to(expectedPrice),
				it("realPrice").to(realPrice),
				it("suggestedShop").to(suggestedShop),
				it("actualShop").to(actualShop),
				it("note").to(note));
      shoppingList.push_back(shoppingItem);
    }
    return shoppingList;
  } 

  void add_shopping_item(ShoppingList* shoppingList, ShoppingItem* shoppingItem){
    string s;
    s.
  
  
  }

