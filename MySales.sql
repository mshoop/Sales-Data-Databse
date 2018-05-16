/* Create Database */
CREATE TABLE MySales ( pname VARCHAR (15), discount CHAR(4), month CHAR(3), price INTEGER)


/* Functional dependencies considered: */
-- pname -> discount
SELECT * FROM MySales S1, MySales S2 WHERE S1.pname = S2.pname AND S1.discount != S2.discount
-- pname -> month
SELECT * FROM MySales S1, MySales S2 WHERE S1.pname = S2.pname AND S1.month != S2.month
-- pname -> price
SELECT * FROM MySales S1, MySales S2 WHERE S1.pname = S2.pname AND S1.price!= S2.price -- FD: pname->price
-- discount -> pname
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.pname != S2.pname
-- discount -> month
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.month != S2.month
-- discount -> price
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.price != S2.price
-- month -> pname
SELECT * FROM MySales S1, MySales S2 WHERE S1.month = S2.month AND S1.discount != S2.discount -- FD: month -> discount
-- month -> discount
SELECT * FROM MySales S1, MySales S2 WHERE S1.month = S2.month AND S1.pname != S2.pname
-- month -> price
SELECT * FROM MySales S1, MySales S2 WHERE S1.month = S2.month AND S1.price != S2.price
-- price -> pname
SELECT * FROM MySales S1, MySales S2 WHERE S1.price = S2.price AND S1.discount != S2.discount
-- price -> discount
SELECT * FROM MySales S1, MySales S2 WHERE S1.price = S2.price AND S1.pname != S2.pname
-- price -> month
SELECT * FROM MySales S1, MySales S2 WHERE S1.price = S2.price AND S1.month != S2.month
-- pname,discount -> month
SELECT * FROM MySales S1, MySales S2 WHERE S1.pname = S2.pname AND S1.discount = S2.discount AND S1.month != S2.month
-- pname,price -> month
SELECT * FROM MySales S1, MySales S2 WHERE S1.pname = S2.pname AND S1.price = S2.price AND S1.month != S2.month
-- pname,price -> discount
SELECT * FROM MySales S1, MySales S2 WHERE S1.pname = S2.pname AND S1.price = S2.price AND S1.discount != S2.discount
-- discount,month -> pname
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.month = S2.month AND S1.pname != S2.pname
-- discount,month -> price
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.month = S2.month AND S1.price != S2.price
-- discount,price -> pname
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.price = S2.price AND S1.pname != S2.pname
-- discount,price -> month
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.price = S2.price AND S1.month != S2.month
-- month,price -> pname
SELECT * FROM MySales S1, MySales S2 WHERE S1.month = S2.month AND S1.price = S2.price AND S1.pname != S2.pname
-- pname,discount,price -> month
SELECT * FROM MySales S1, MySales S2 WHERE S1.pname = S2.pname AND S1.discount = S2.discount AND S1.price = S2.price AND S1.month != S2.month
-- discount,price,month -> pname
SELECT * FROM MySales S1, MySales S2 WHERE S1.discount = S2.discount AND S1.price = S2.price AND S1.month = S2.month AND S1.pname != S2.pname
/*
DONT need to CHECK:
pname,discount,month -> price 
pname,month,price -> discount 
pname,discount -> price 
pname,month -> discount 
pname,month -> price 
month,price -> discount*/


/* Create new tables for the decomposed schema: */
CREATE TABLE Price (
    pname VARCHAR (15),
    price INTEGER,
    PRIMARY KEY(pname))

CREATE TABLE Discount (
    month CHAR(3),
    discount CHAR(4),
    PRIMARY KEY(month))

CREATE TABLE Sales (
    pname VARCHAR (15),
    month CHAR(3),
    PRIMARY KEY(pname,month),
    FOREIGN KEY (pname) REFERENCES Price(pname),
    FOREIGN KEY (month) REFERENCES Discount(month))


/* Populate decomposed BCNF tables: */
INSERT INTO Price(SELECT pname,price FROM MySales GROUP BY (pname,price) ORDER BY (pname,price)) 
-- Total 36 tuples

INSERT INTO Discount (SELECT month,discount FROM MySales GROUP BY (month,discount) ORDER BY (month,discount)) 
-- Total 12 tuples

INSERT INTO Sales (SELECT pname,month FROM MySales GROUP BY (pname,month) ORDER BY (pname,month)) 
-- Total 426 tuples 

