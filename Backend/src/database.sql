-- drop database if exists company;
-- create database company;
-- use company;



-- create table customer (
-- 	id int(11) not null auto_increment,
-- 	username varchar(15) not null,
--     name varchar(20) not null,
--     lastname varchar(20) not null,
--     mail varchar(50) not null,
--     password varchar(30) not null,
--     primary key(id)
-- );

-- describe customer;

-- DROP procedure IF EXISTS `addoredit_customer`;

-- DELIMITER $$
-- USE `company`$$
-- create procedure addoredit_customer(
-- 	in _id int, 
--     in _username varchar(15),
--     in _name varchar(20),
--     in _lastname varchar(20),
--     in _mail varchar(50),
--     in _password varchar(30)
-- )
-- begin
	
--     if _id = 0 then
-- 		insert into customer (username, name, lastname, mail, password) values (_username, _name, _lastname, _mail, _password);
--         set _id = last_insert_id();
-- 	else
-- 		update customer
--         set username = _username, name = _name, lastname = _lastname, mail = _mail, password = _password 
--         where id = _id;
-- 	end if;
    
--     select _id as id;
-- end$$

-- DELIMITER ;


-- insert into customer values(0001, 'root', 'Stan', 'Smith', 'stan.smith@gmail.com','Acngj-rjhjg-skfj34-54nsdf');

-- select * from customer;







-- drop database if exists company;
-- create database company;
-- use company;

-- create table user (
-- 	id int not null,
--     username varchar(15) not null,
--     name varchar(20) not null,
--     lastname varchar(20) not null,
--     mail varchar(50) not null,
--     randomstr varchar(250) not null,
--     hash varchar(250) not null,
--     primary key(id)
-- );