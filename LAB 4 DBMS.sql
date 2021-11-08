create database Lab_E_Commerce;
use Lab_E_Commerce;
create table Supplier( SUPP_ID int , SUPP_NAME varchar(50) ,SUPP_CITY varchar(50),SUPP_PHONE bigint);
select * from supplier;
create table Customer(CUS_ID int , CUS_NAME varchar(50) , CUS_PHONE bigint , CUS_CITY varchar(50) , CUS_GENDER varchar(5));
create table Category(CAT_ID int , CAT_NAME varchar(50));
create table Product(PRO_ID int , PRO_NAME varchar(50) , PRO_DESC varchar(50) , CAT_ID int);
create table ProductDetails(PROD_ID int ,PRO_ID int , SUPP_ID int , PRICE int);
create table Orders(ORD_ID int , ORD_AMOUNT int , ORD_DATE varchar(50) , CUS_ID int , PROD_ID int);
create table Rating(RAT_ID int , CUS_ID int , SUPP_ID int , RAT_RATSTARS int);
insert into Supplier values (1 ,"Rajesh Retails" , "Delhi", 1234567890);
insert into Supplier values (2 , "Appario Ltd." , "Mumbai" , 2589631470);
insert into Supplier values (3 , "Knome products" , "Banglore" , 9785462315);
insert into Supplier values (4 , "Bansal Retails" , "Kochi" , 8975463285);
insert into Supplier values (5 , "Mittal Ltd." , "Lucknow" , 7898456532);
insert into Customer values (1 , "AAKASH" , 9999999999 , "DELHI" , "M");
insert into Customer values (2 , "AMAN" , 9785463215 , "NOIDA" , "M");
insert into Customer values (3 , "NEHA" , 9999999999 , "MUMBAI" , "F");
insert into Customer values (4 , "MEGHA" , 9994562399 , "KOLKATA" , "F");
insert into Customer values (5 , "PULKIT" , 7895999999 , "LUCKNOW" , "M");
insert into Category values (1 , "BOOKS");
insert into Category values (2 , "GAMES");
insert into Category values (3 , "GROCERIES");
insert into Category values (4 , "ELECTRONICS");
insert into Category values (5 , "CLOTHES");
insert into Product values (1 , "GTA V" , "DFJDJFDJFDJFDJFJF" , 2);
insert into Product values (2 , "TSHIRT" , "DFDFJDFJDKFD" , 5);
insert into Product values (3 , "ROG LAPTOP" , "DFNTTNTNTERND" , 4);
insert into Product values (4 , "OATS" , "REURENTBTOTH" , 3);
insert into Product values (5 , "HARRY POTTER" , "NBEMCTHTJTH" , 1);
insert into ProductDetails values (1 , 1 , 2 , 1500);
insert into ProductDetails values (2 , 3 , 5 , 30000);
insert into ProductDetails values (3 , 5 , 1 , 3000);
insert into ProductDetails values (4 , 2 , 3 , 2500);
insert into ProductDetails values (5 , 4 , 1 , 1000);
insert into ProductDetails values (5 , 4 , 1 , 1000);
insert into Orders values (20 , 1500 , "2021-10-12" , 3 , 5);
insert into Orders values (25 , 30500 , "2021-09-16" , 5 , 2);
insert into Orders values (26 , 2000 , "2021-10-05" , 1 , 1);
insert into Orders values (30 , 3500 , "2021-08-16" , 4 , 3);
insert into Orders values (50 , 2000 , "2021-10-06" , 2 , 1);
insert into Rating values (1 , 2 , 2 , 4);
insert into Rating values (2 , 3 , 4 , 3);
insert into Rating values (3 , 5 , 1 , 5);
insert into Rating values (4 , 1 , 3 , 2);
insert into Rating values (5 , 4 , 5 , 4);
select * from Customer;
select * from Category;
select * from Product;
select * from ProductDetails;
select * from Orders;
select * from Rating;



select count(CUS_GENDER) from Customer join Orders on Customer.CUS__ID = Orders.CUS_ID where ORD_AMOUNT>=3000 group by CUS_GENDER;

select ORD_ID, ORD_AMOUNT, ORD_DATE, p2.PRO_ID, PRO_NAME from Orders o
join ProductDetails p1 on o.PROD_ID = p1.PROD_ID join product p2 on p1.PRO_ID = p2.PRO_ID where o.CUS_ID = 2;

select s.* from supplier s join ProductDetails p on s.SUPP_ID = p.SUPP_ID
group by p.SUPP_ID having count(p.SUPP_ID) > 1;

select Category.* from Orders inner join ProductDetails on Orders.PROD_ID=ProductDetails.PROD_ID 
inner join Product on Product.PRO_ID=ProductDetails.PRO_ID inner join Category on 
Category.CAT_ID=Product.CAT_ID having min(Orders.ORD_AMOUNT);

select p.PRO_ID, PRO_NAME from Product p join ProductDetails p1 on p.PRO_ID = p1.PRO_ID join
Orders o on p1.PROD_ID = o.PROD_ID where ORD_DATE > "2021-10-05";

select s.SUPP_ID, SUPP_NAME, CUS_NAME, RAT_RATSTARS from Supplier s join Rating r on s.SUPP_ID = r.SUPP_ID join
Customer c on r.CUS_ID = c.CUS__ID order by RAT_RATSTARS desc limit 3;

select CUS_NAME, CUS_GENDER from Customer where CUS_NAME like 'A%' or CUS_NAME like '%A';

select sum(ORD_AMOUNT) from Orders o join Customer c on o.CUS_ID = c.CUS__ID and CUS_GENDER = "M";

select * from Customer c left join Orders o on c.CUS__ID = o.CUS_ID;

delimiter &&
create procedure displayRating()
begin
select s.SUPP_ID, SUPP_NAME, RAT_RATSTARS, 
case
when RAT_RATSTARS > 4 then 'Genuine Suuplier'
when RAT_RATSTARS > 2 then 'Average Supplier'
else 'Supplier should not be considered'
end as Verdict
from Supplier s join Rating r on s.SUPP_ID = r.SUPP_ID;
end &&
call displayRating();