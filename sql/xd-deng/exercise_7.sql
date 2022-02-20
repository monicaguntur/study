-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
select client.name from client, package where client.accountnumber = package.recipient and package.weight = 1.5;
-- 7.2 What is the total weight of all the packages that he sent?
select sum(weight) from package where sender = (select client.accountnumber from client, package where client.accountnumber = package.recipient and package.weight = 1.5);