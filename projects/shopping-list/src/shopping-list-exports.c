extern "C"{

  ShoppingList get_shopping_list(User* user);
  void add_item(ShoppingList* shoppingList, ShoppingItemId*
		id);
  void remove_item(ShoppingList* shoppingList, ShoppingItemId*
		   id);
  ShoppingItem get_item(ShoppingItemId* id);
  ItemList list_items();
}
