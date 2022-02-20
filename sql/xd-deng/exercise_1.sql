-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store
-- 1.1 Select the names of all the products in the store.
select name from products;
-- 1.2 Select the names and the prices of all the products in the store.
select name, price from products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
select name from products where price <= 200;
-- 1.4 Select all the products with a price between $60 and $120.
select * from products where price between 60 and 120;
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select name, price*100 from 
-- 1.6 Compute the average price of all the products.
select name, price*100 as price_cents from products;
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(price) from products where manufacturer = 2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(*) from products where price >= 180;
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select name, price from products where price >= 180 order by price ASC, name DESC;
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select p.*, m.* from products as p, manufacturers as m where p.manufacturer = m.code;
-- 1.11 Select the product name, price, and manufacturer name of all the products.
select p.name, p.price, m.name from products as p, manufacturers as m where p.manufacturer = m.code;
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select m.code, avg(p.price) as avg_price from products as p, manufacturers as m where p.manufacturer = m.code group by m.code;
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select m.name, avg(p.price) as avg_price from products as p, manufacturers as m where p.manufacturer = m.code group by m.code;
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
select m.name, avg(p.price) as avg_price from products as p, manufacturers as m where p.manufacturer = m.code group by m.code having avg(p.price) >= 150;
-- 1.15 Select the name and price of the cheapest product.
select name, price from products where price = (select min(price) as min_price from products);
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select og.name, og.price, og.manufacturer 
from 
(select p.name as name, p.price as price, m.name as manufacturer, m.code as manu_code from products as p, manufacturers as m where p.manufacturer = m.code) as og 
left join 
(select manufacturer, max(price) as max_price from products group by manufacturer) as sq 
on (og.manu_code = sq.manufacturer and og.price = sq.max_price);

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into products values (11, 'Loudspeakers', 70, 2);
-- 1.18 Update the name of product 8 to "Laser Printer".
update products set name = 'Laser Printer' where code = 8;
-- 1.19 Apply a 10% discount to all products.
update products set price = price*0.9 where code is not NULL;
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
update products set price = price*0.9 where price >= 120;
