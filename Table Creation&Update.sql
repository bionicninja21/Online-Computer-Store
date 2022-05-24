CREATE DATABASE NEWARKIT;

SHOW DATABASES;
USE NEWARKIT;

SHOW TABLES;

#CREATING TABLES 

CREATE TABLE CUSTOMER (CID CHAR(5) NOT NULL, FNAME VARCHAR(20) NOT NULL, LNAME VARCHAR(20) NOT NULL, 
EMAIL VARCHAR(20) NOT NULL, ADDRESS VARCHAR(50), PHONE CHAR(10), STATUS VARCHAR(10) NOT NULL DEFAULT 'regular',
PRIMARY KEY (CID));

CREATE TABLE SILVER_AND_ABOVE (CID CHAR(5) NOT NULL, CREDITLINE INTEGER,
CONSTRAINT SAB_FK
FOREIGN KEY (CID) REFERENCES CUSTOMER (CID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE PRODUCT (PID CHAR(10) NOT NULL, PTYPE VARCHAR(20) NOT NULL, PNAME VARCHAR(20) NOT NULL, PPRICE DECIMAL(10,2) NOT NULL,
DESCRIPTION VARCHAR(50), PQUANTITY INTEGER, 
PRIMARY KEY(PID));

CREATE TABLE COMPUTER (PID CHAR(10) NOT NULL, CPUTYPE VARCHAR(15) NOT NULL,
CONSTRAINT COMP_FK
FOREIGN KEY (PID) REFERENCES PRODUCT (PID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE PRINTER (PID CHAR(10) NOT NULL, PRINTERTYPE VARCHAR(15), RESOLUTION INTEGER, 
CONSTRAINT PRINT_FK
FOREIGN KEY (PID) REFERENCES PRODUCT (PID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE LAPTOP (PID CHAR(10) NOT NULL, BODYTYPE VARCHAR(15), WEIGHT DECIMAL(10,2), 
CONSTRAINT LAP_FK
FOREIGN KEY (PID) REFERENCES COMPUTER (PID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE OFFER_PRODUCT (PID CHAR(10) NOT NULL, OFFERPRICE DECIMAL(10,2),
CONSTRAINT OFF_PK 
FOREIGN KEY (PID) REFERENCES PRODUCT (PID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE BASKET (CID CHAR(5) NOT NULL, BID CHAR(10) NOT NULL,
PRIMARY KEY(BID),
CONSTRAINT BASK_FK
FOREIGN KEY(CID) REFERENCES CUSTOMER(CID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE APPEARS_IN (BID CHAR(10) NOT NULL, PID CHAR(10) NOT NULL, QUANTITY INTEGER NOT NULL, 
PRICESOLD DECIMAL (10,2) NOT NULL, 
CONSTRAINT APP1_FK 
FOREIGN KEY(BID) REFERENCES BASKET(BID)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT APP2_FK
FOREIGN KEY(PID) REFERENCES PRODUCT(PID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE CREDIT_CARD (CCNUMBER CHAR(16) NOT NULL, SECNUMBER CHAR(3) NOT NULL, OWNERNAME VARCHAR(20) NOT NULL,
CCTYPE VARCHAR(15) NOT NULL, BILADDRESS VARCHAR(50) NOT NULL, EXPDATE DATE NOT NULL, STOREDCARDCID CHAR(5),
PRIMARY KEY(CCNUMBER),
CONSTRAINT CC_FK
FOREIGN KEY(STOREDCARDCID) REFERENCES CUSTOMER (CID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE SHIPPING_ADDRESS (CID CHAR(5) NOT NULL, SANAME VARCHAR(15) NOT NULL, RECIPIENTNAME VARCHAR(20) NOT NULL, 
STREET VARCHAR(15) NOT NULL, SNUMBER INTEGER, CITY VARCHAR(15) NOT NULL, ZIP INTEGER NOT NULL,
STATE VARCHAR(15) NOT NULL, COUNTRY VARCHAR(15) NOT NULL, 
PRIMARY KEY(CID,SANAME),
CONSTRAINT SA_FK
FOREIGN KEY (CID) REFERENCES CUSTOMER(CID)
ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE TRANSACTION (BID CHAR(10) NOT NULL, CCNUMBER CHAR(16) NOT NULL, CID CHAR(5) NOT NULL,
SANAME VARCHAR(15) NOT NULL, TDATE DATE, TTAG VARCHAR(10),
CONSTRAINT TRANS1_FK 
FOREIGN KEY (CCNUMBER) REFERENCES CREDIT_CARD (CCNUMBER)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT TRANS2_FK
FOREIGN KEY (BID) REFERENCES BASKET (BID)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT TRANS3_FK
FOREIGN KEY (CID,SANAME) REFERENCES SHIPPING_ADDRESS (CID,SANAME)
ON UPDATE CASCADE ON DELETE CASCADE);

SHOW TABLES;

#INSERTING VALUES INTO TABLES 

INSERT INTO CUSTOMER (CID, FNAME, LNAME, EMAIL, ADDRESS, PHONE, STATUS) VALUES 
(17856, 'Ralph', 'Butler', 'rbut@gmail.com', '999 Pearl Street', 8159732046, 'regular'),
(28734, 'William', 'Brown', 'wilb@gmail.com', '425 Wood Lane', 8159732076, 'silver'),
(30328, 'Lauren', 'Torres', 'lautorr@gmail.com', '7248 S. Roberts Lane', 4651845897, 'regular'),
(42545, 'Bianca', 'Smith', 'bsmith@gmail.com', '316 South Walnutwood Road', 7589692045, 'gold'),
(50823, 'Jermaine', 'Bonilla', 'jbon@gmail.com', '976 S. High Dr.', 9041520546, 'platinum'),
(60284, 'John', 'Adams', 'jadam@gmail.com', '349 Nichols Ave.', 5832357578, 'gold'),
(76153, 'Justin', 'Warner', 'jwarner@gmail.com', '8085 Plymouth Ave.', 1911623860, 'regular'),
(89735, 'Paul', 'Butler', 'paulbut@gmail.com', '67 Union St.', 7510708386, 'platinum'),
(99265, 'Ralph', 'Sullivan', 'rsul@gmail.com', '9558 Riverside St.', 7804548541, 'silver'),
(10038, 'Hannah', 'Lucas', 'halu@gmail.com', '46 Riverview St.', 3239218328, 'regular'),
(11983, 'John', 'Fowler', 'jfow@gmail.com', '551 Lafayette Street', 5266964279, 'silver'),
(12143, 'Gary', 'Mayo', 'garm@gmail.com', '979 Lexington Street', 5406891691, 'regular'),
(13748, 'Thomas', 'Reed', 'tomreed@gmail.com', '18 Armstrong St.', 7599489625, 'regular'),
(14934, 'Emily', 'Schultz', 'emschu@gmail.com', '8554 Nicolls Street', 2627182011, 'platinum'),
(15546, 'James', 'Anderson', 'jander@gmail.com', '455 Tailwater Drive', 2145214078, 'platinum'),
(16928, 'Tracy', 'Hernandez', 'ther@gmail.com', '8163 North Wrangler Street', 9665949352, 'regular'),
(17444, 'Kimberly', 'Morales', 'kimm@gmail.com', '5 Bayberry Lane', 7652622071, 'gold'),
(18666, 'Chelsea', 'Wolf', 'chew@gmail.com', '780 Lincoln St.', 4859723838, 'silver'),
(19237, 'Theresa', 'Vazquez', 'thev@gmail.com', '49 Illinois Ave.', 6237488722, 'gold'),
(20938, 'Jack', 'Ryan', 'jacry@gmail.com', '5 Plymouth Rd.', 2771384154, 'regular');  
SELECT * FROM CUSTOMER;

INSERT INTO SILVER_AND_ABOVE (CID, CREDITLINE) VALUES
(17856, 800),
(28734, 2000),
(30328, 500),
(42545, 5000),
(50823, 10000),
(60284, 7000),
(76153, 300),
(89735, 15000),
(99265, 9000),
(10038, 750),
(11983, 7500),
(12143, 900),
(13748, 600),
(14934, 20000),
(15546, 35000),
(16928, 100),
(17444, 8000),
(18666, 5000),
(19237, 15000),
(20938, 350);  
SELECT * FROM SILVER_AND_ABOVE;

INSERT INTO PRODUCT (PID, PTYPE, PNAME, PPRICE, DESCRIPTION, PQUANTITY) VALUES
(2131254325, 'Computer', 'Dell', 9999.99, 'excellent tech specs and upgradability', 8),
(1738579007, 'Laptop', 'Dell', 1589.99, 'excellent tech specs and upgradability', 19),
(4775340856, 'Computer', 'MAC', 2399.99, 'excellent tech specs and upgradability', 11),
(2775460684, 'Printer', 'HP', 800, 'excellent tech specs and upgradability', 5),
(1134046455, 'Computer', 'Dell', 350, 'excellent tech specs and upgradability', 6),
(4823139584, 'Laptop', 'Dell', 3000, 'excellent tech specs and upgradability', 3),
(2100441091, 'Computer', 'Dell', 1500, 'excellent tech specs and upgradability', 7),
(2041688904, 'Printer', 'Epson', 999, 'excellent tech specs and upgradability', 16),
(5597197354, 'Computer', 'Dell', 409, 'excellent tech specs and upgradability', 16),
(8592516488, 'Laptop', 'MAC', 3000, 'excellent tech specs and upgradability', 9),
(1710869346, 'Printer', 'HP', 900, 'excellent tech specs and upgradability', 8),
(9606367818, 'Printer', 'Epson', 989.99, 'excellent tech specs and upgradability', 15),
(4249381140, 'Computer', 'Dell', 1700, 'excellent tech specs and upgradability', 12),
(5495308110, 'Laptop', 'HP', 5000, 'excellent tech specs and upgradability', 8),
(2131254345, 'Computer', 'Dell', 5669.99, 'excellent tech specs and upgradability', 9),
(4686897236, 'Computer', 'MAC', 670, 'excellent tech specs and upgradability', 5),
(3207804735, 'Laptop', 'Dell', 1800, 'excellent tech specs and upgradability', 8),
(5938351115, 'Computer', 'HP', 700, 'excellent tech specs and upgradability', 12),
(2064581284, 'Printer', 'Epson', 679.99, 'excellent tech specs and upgradability', 7),
(7006373882, 'Laptop', 'Dell', 1300, 'excellent tech specs and upgradability', 8);
SELECT * FROM PRODUCT;

INSERT INTO COMPUTER (PID, CPUTYPE) VALUES
(2131254325, 'Single-core'),
(4775340856, 'Dual-core '),
(1134046455, 'Quad-core'),
(2100441091, 'Quad-core'),
(5597197354, 'Octa-core'),
(4249381140, 'Quad-core'),
(2131254345, 'Dual-core '),
(4686897236, 'Quad-core'),
(5938351115, 'Dual-core'),
(1738579007, 'Dual-core'),
(4823139584, 'Octa-core'),
(8592516488, 'Dual-core'),
(5495308110, 'Quad-core'),
(3207804735, 'Dual-core'),
(7006373882, 'Quad-core');
SELECT * FROM COMPUTER;

INSERT INTO PRINTER (PID, PRINTERTYPE, RESOLUTION) VALUES
(2775460684, 'Laser', 700),
(2041688904, 'Dot Matrix', 300),
(1710869346, 'Laser', 900),
(9606367818, 'Laser', 800),
(2064581284, 'Dot Matrix', 500);
SELECT * FROM PRINTER;

INSERT INTO LAPTOP (PID, BODYTYPE, WEIGHT) VALUES
(1738579007, 'metal', 9.5),
(4823139584, 'plastic', 3),
(8592516488, 'plastic', 5.0),
(5495308110, 'metal', 8),
(3207804735, 'plastic', 3.54),
(7006373882, 'metal', 8);
SELECT * FROM LAPTOP;

INSERT INTO OFFER_PRODUCT (PID, OFFERPRICE) VALUES
(4823139584, 2000),
(2100441091, 1000),
(2041688904, 900),
(5597197354, 399.99),
(8592516488, 2599),
(1710869346, 800);
SELECT * FROM OFFER_PRODUCT;

INSERT INTO BASKET (CID, BID) VALUES
(50823, 2798263999),
(60284, 9969582035),
(76153, 4122706679),
(89735, 6617509362),
(99265, 8555134848),
(10038, 4128222897),
(11983, 5146024567),
(12143, 3121782971),
(13748, 6636125710),
(14934, 1543681166);
SELECT * FROM BASKET;

INSERT INTO APPEARS_IN (BID, PID, QUANTITY, PRICESOLD) VALUES
(2798263999, 2131254325, 1, 9999.99),
(9969582035, 1738579007, 1, 1589.99),
(4122706679, 4775340856, 2, 2399.99),
(6617509362, 2775460684, 3, 800),
(8555134848, 1134046455, 2, 350),
(4128222897, 7006373882, 1, 1300),
(5146024567, 2064581284, 4, 679.99),
(3121782971, 5938351115, 1, 700),
(6636125710, 3207804735, 2, 1800),
(1543681166, 4686897236, 1, 670);
SELECT * FROM APPEARS_IN;

INSERT INTO CREDIT_CARD (CCNUMBER, SECNUMBER, OWNERNAME, CCTYPE, BILADDRESS, EXPDATE, STOREDCARDCID) VALUES
(3273128014967748, 234, 'Ralph', 'Mastercard', '999 Pearl Street', '2023-03-12', 17856),
(8439832856643311, 654, 'William', 'Visa', '425 Wood Lane', '2024-05-12', 28734),
(3066992145714306, 785, 'Lauren', 'Mastercard', '7248 S. Roberts Lane', '2024-09-19', 30328),
(5200040340502533, 176, 'Bianca', 'Visa', '316 South Walnutwood Road', '2025-12-12', 42545),
(8466946560594729, 284, 'Jermaine', 'Mastercard', '976 S. High Dr.', '2022-12-21', 50823),
(3513100924045407, 927, 'Jack', 'Visa', '5 Plymouth Rd.', '2026-03-12', 20938),
(9446695439513793, 307, 'Theresa', 'Mastercard', '49 Illinois Ave.', '2027-01-01', 19237),
(8127566146016121, 193, 'Chelsea', 'Visa', '780 Lincoln St.', '2026-02-19', 18666),
(1477355039575495, 109, 'Kimberly', 'Visa', '5 Bayberry Lane', '2028-01-01', 17444),
(9069520361809532, 657, 'Tracy', 'Visa', '8163 North Wrangler Street', '2023-09-19',  16928),
(4124149564175886, 222, 'John', 'Mastercard', '349 Nichols Ave.', '2023-03-22', 60284),
(9587744645457282, 333, 'Justin', 'Mastercard', '8085 Plymouth Ave.', '2025-03-12', 76153),
(7935429137821919, 444, 'Paul', 'Visa', '67 Union St.', '2023-03-02', 89735),
(4762937767219882, 555, 'Sullivan', 'Mastercard', '9558 Riverside St.', '2026-08-12', 99265),
(9783811093136502, 666, 'Hannah', 'Visa', '46 Riverview St.', '2026-03-17', 10038),
(9212276993170101, 777, 'Fowler', 'Mastercard', '551 Lafayette Street', '2024-03-12', 11983),
(0201618111945194, 888, 'Gary', 'Visa', '979 Lexington Street', '2023-09-12', 12143),
(7759420984805777, 999, 'Thomas', 'Mastercard', '18 Armstrong St.', '2029-03-11', 13748),
(0598404695090895, 001, 'Emily', 'Visa', '8554 Nicolls Street', '2027-07-12', 14934),
(6205960598878702, 121, 'James', 'Mastercard', '455 Tailwater Drive', '2028-03-12', 15546);
SELECT * FROM CREDIT_CARD;

INSERT INTO SHIPPING_ADDRESS (CID, SANAME, RECIPIENTNAME, STREET, SNUMBER, CITY, ZIP, STATE, COUNTRY) VALUES
(17856, 'Home', 'Ralph', 'Pearl Street', 999 , 'Newark', 07072, 'NJ', 'USA'),
(28734, 'Office', 'William', 'Wood Lane', 425 , 'Newark', 07072, 'NJ', 'USA'),
(30328, 'Home', 'Lauren', 'S. Roberts Lane', 7248 , 'Newark', 07072, 'NJ', 'USA'),
(42545, 'Home', 'Bianca', 'South Walnut Rd', 316 , 'Newark', 07072, 'NJ', 'USA'),
(50823, 'Home', 'Jermaine', 'S. High Dr.', 976 , 'Newark', 07072, 'NJ', 'USA'),
(20938, 'Home', 'Jack', 'Plymouth Rd.', 5 , 'Newark', 07072, 'NJ', 'USA'),
(19237, 'Office', 'Theresa', 'Illinois Ave.', 49 , 'Newark', 07072, 'NJ', 'USA'),
(18666, 'Home', 'Chelsea', 'Lincoln St.', 780 , 'Newark', 07072, 'NJ', 'USA'),
(17444, 'Office', 'Kimberly', 'Bayberry Lane', 5 , 'Newark', 07072, 'NJ', 'USA'),
(16928, 'Office', 'Tracy', 'N Wrangler St', 8163 , 'Newark', 07072, 'NJ', 'USA'),
(60284, 'Home', 'John', 'Nichols Ave.', 349, 'Newark', 07072, 'NJ', 'USA'),
(76153, 'Office', 'Justin', 'Plymouth Ave.', 8085 , 'Newark', 07072, 'NJ', 'USA'),
(89735, 'Home', 'Paul', 'Union St.', 67 , 'Newark', 07072, 'NJ', 'USA'),
(99265, 'Office', 'Sullivan', 'Riverside St.', 9558 , 'Newark', 07072, 'NJ', 'USA'),
(10038, 'Office', 'Hannah', 'Riverview St.', 46 , 'Newark', 07072, 'NJ', 'USA'),
(11983, 'Home', 'Fowler', 'Lafayette St', 551 , 'Newark', 07072, 'NJ', 'USA'),
(12143, 'Home', 'Gary', 'Lexington St', 979 , 'Newark', 07072, 'NJ', 'USA'),
(13748, 'Office', 'Thomas', 'Armstrong St.', 18 , 'Newark', 07072, 'NJ', 'USA'),
(14934, 'Home', 'Emily', 'Nicolls Street', 8554 , 'Newark', 07072, 'NJ', 'USA'),
(15546, 'Home', 'James', 'Tailwater Drive', 455 , 'Newark', 07072, 'NJ', 'USA');
SELECT * FROM SHIPPING_ADDRESS;

INSERT INTO TRANSACTION (BID, CCNUMBER, CID, SANAME, TDATE, TTAG) VALUES
(2798263999, 8466946560594729, 50823, 'Home', '2022-04-28', 'Processing'),
(9969582035, 4124149564175886, 60284, 'Home', '2022-04-22', 'Shipped'),
(4122706679, 9587744645457282, 76153, 'Office', '2022-04-29', 'Processing'),
(6617509362, 7935429137821919, 89735, 'Home', '2022-03-30', 'Delivered'),
(8555134848, 4762937767219882, 99265, 'Office', '2022-04-22', 'Shipped'),
(4128222897, 9783811093136502, 10038, 'Office', '2022-02-20', 'Delivered'),
(5146024567, 9212276993170101, 11983, 'Home', '2022-04-27', 'Processing'),
(3121782971, 0201618111945194, 12143, 'Home', '2022-04-12', 'Shipped'),
(6636125710, 7759420984805777, 13748, 'Office', '2022-04-01', 'Delivered'),
(1543681166, 0598404695090895, 14934, 'Home', '2022-04-26', 'Processing');
SELECT * FROM TRANSACTION;

DROP DATABASE NEWARKIT;

