-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
-- 5.1 Select the name of all the pieces. 
select name from pieces;
-- 5.2  Select all the providers' data. 
select * from providers;
-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
select piece, avg(price) from provides group by piece;
-- 5.4  Obtain the names of all providers who supply piece 1.
select name from providers where code in (select provider from provides where piece = 1);
-- 5.5 Select the name of pieces provided by provider with code "HAL".
select name from pieces where code in (select piece from provides where provider = 'HAL');
-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
select mppp.name as piece, providers.name as provider, mppp.max as price from providers, (select mpp.name, provides.provider as providercode, mpp.max from provides right join (select p.name, mp.* from pieces as p, (select piece, max(price) from provides group by piece) as mp where mp.piece = p.code) as mpp on mpp.max = provides.price and
mpp.piece = provides.piece) as mppp where mppp.providercode = providers.code;
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
insert into provides values (1,'TNBC', 7);
-- 5.8 Increase all prices by one cent.
update provides set price = price+1;
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
delete from provides where provider = 'RBT' and piece = 4;
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
delete from provides where provider = 'RBT';