create table ShoppingList(
--       actualShop text,
       byWhen date,
       expectedPrice int,
--     fromWhere text,
       note text2,
       purchased boolean not null,
       quantity integer check (quantity > 0),
--       realPrice int,
       suggestedShop text,
--       whenPurchased date,
       shoppingItemId integer references ShoppingItem (id));

create table ShoppingItem(
       brand text,
       id integer primary key,
       name text not null);

create table ShoppingItemAnalytics(
       shopPurchasedFrom text,
       price int,
       shoppingItemId integer references ShoppingItem(id),
       whenLastPurchased date);

