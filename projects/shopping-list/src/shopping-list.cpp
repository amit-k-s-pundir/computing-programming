#include <string>
#include <vector>

using namespace std;

class ShoppingList{
private:
  vector<ShoppingItem> shoppingItems;
};

class ShoppingItem{
public:
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

  ShoppingItem(string name, string brand, double quantity, bool purchased, string fromWhere, string note,
	       date byWhen, date whenPurchased, doule expectedPrice, string suggestedShop,
	       string actualShop);
  template<T> bool persist(T t);
  bool serialize();
  ShoppingItem deserialize();
};

class DataStore{
public:
  DataStore();
  ~DataStore();
  initialize();
}
template<T> class ShoppingItemPersistence{
  public:
  ShoppingItemPersistence(T t);
  bool persist(ShoppingItem shoppingItem);
  ShoppingItem create();

 private:
  T t;
};

bool ShoppingItemPersistence<T>::persist(ShoppingItem shoppingItem){
  t.persist(shoppingItem);
  
}

ShoppingItem ShoppingItemPersistence::create(){
  t.create();
}
					 
struct ShoppingItemPersistencePostgres{
  bool persist(ShoppingItem ShoppingItem);
  ShoppingItem create();
};

bool ShoppingItemPersistencePostgres::persist(ShoppingItem shoppingItem){
  return true;
}

ShoppingItem ShoppingItemPersistencePostgres::create(){
  string s;
  
}

  
					 
					 


 




















