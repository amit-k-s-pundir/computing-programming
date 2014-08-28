drop table ShoppingItem cascade;
drop table ShoppingItemDetails cascade;
drop table ShoppingList;

create table ShoppingItem(
       brand text,
       id serial primary key,
       name text not null,
--       primary key (brand, name),
       unique (brand, name));

create table ShoppingItemDetails(
--       actualShop text,
       byWhen date,
       expectedPrice integer,
--     fromWhere text,
       note text,
--       purchased boolean not null,
       quantity integer check (quantity > 0),
       id serial primary key,
--       realPrice int,
       suggestedShop text
--       whenPurchased date,
--       shoppingItemId integer references ShoppingItem (id)
	 );

-- create table ShoppingItemAnalytics(
--        shopPurchasedFrom text,
--        price int,
--        shoppingItemId integer references ShoppingItem(id),
--        whenLastPurchased date);

create table ShoppingList(
shoppingItemId integer references ShoppingItem(id) on delete restrict,
shoppingItemDetailsId integer references ShoppingItemDetails(id) on delete restrict

-- primary key (shoppingItemId, shoppingItemDetailsId)
);
