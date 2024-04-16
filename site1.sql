create DATABASE SITEA;
-- Use the First Location database
USE SiteA;

-- Create table for Inventory of Site A
CREATE TABLE INVA (
  InvIdA INT  PRIMARY KEY NOT NULL,
  Capacity INT NOT NULL
);

-- insert sample data into Inv Table
INSERT INTO INVA (InvIdA, Capacity)
VALUES 
  (1, 250);
  
-- Create table for Locations
CREATE TABLE LocationA (
  LocIdA INT  PRIMARY KEY NOT NULL,
  Address VARCHAR(200) NOT NULL,
  InvenId INT NOT NULL,
  FOREIGN KEY (InvenId) REFERENCES INVA(InvIdA)
);  

-- insert sample data into Location Table
INSERT INTO LocationA (LocIdA, Address , InvenId)
VALUES 
    (1, '123 Main Street',1)
    ; 
 -- Create table for Suppliers
CREATE TABLE SuppliersA (
  SuppIdA INT  PRIMARY KEY NOT NULL,
  phone VARCHAR(20) NOT NULL,
  Name VARCHAR(100) NOT NULL
);  

-- insert sample data into Suppliers Table
INSERT INTO SuppliersA (SuppIdA, Name, phone)
VALUES 
    (1, 'Fady', '0523984'),        
    (2, 'Baraka Company','945312'),         
    (3, 'George','85315'),
    (4, 'Ahmed','953115'),
    (5,'Hayah Factory','5832145')
    ; 
    
CREATE TABLE TransactionA (
  TransIdA INT  PRIMARY KEY NOT NULL,
  TypeT VARCHAR(200) NOT NULL,
  INvID INT NOT NULL,
  SupID INT NOT NULL,
  FOREIGN KEY (INvID) REFERENCES INVA(InvIdA),
  FOREIGN KEY (SupID) REFERENCES SuppliersA(SuppIdA)
); 

-- insert sample data into Transaction Table
INSERT INTO TransactionA (TransIdA, TypeT,INvID,SupID)
VALUES 
    (1, 'Cash',1,2),        
    (2, 'Credit Card',1,1),         
    (3, 'Annual insatllment',1,3),
    (4, 'Cash',1,4),
    (5,'Credit Card',1,5)
    ; 
    
-- Create table for Products
CREATE TABLE ProductsA (
  ProIdA INT  PRIMARY KEY NOT NULL,
  BarCode VARCHAR(100) NOT NULL,
  PName VARCHAR(100) NOT NULL,
  Quantity INT NOT NULL
);  

-- insert sample data into Products Table
INSERT INTO ProductsA (ProIdA, PName, BarCode,Quantity)
VALUES 
    (1, 'Milk', '00005',1500),        
    (2, 'Cheese','90000',600),         
    (3, 'Potato','88888',875)


	-- Create table for Provide relation
CREATE TABLE ProvideA (
  prodid INT NOT NULL,
  supid INT NOT NULL,
  PRIMARY KEY (prodid, supid),
  FOREIGN KEY (prodid) REFERENCES ProductsA(ProIdA),
  FOREIGN KEY (supid) REFERENCES SuppliersA(SuppIdA)
);  

-- Create table for Get relation
CREATE TABLE GetA (
  invid INT NOT NULL,
  proid INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (invid, proid, Quantity),
  FOREIGN KEY (invid) REFERENCES INVA(InvIdA),
  FOREIGN KEY (proid) REFERENCES ProductsA(ProIdA)
);

-- insert sample data into Get Table
INSERT INTO GetA (invid, proid, Quantity)
VALUES 
    (1, 2, 150),        
    (1, 1, 130),         
    (1, 3,200)
    ;




	drop table GetA





