use siteB;
CREATE TABLE INVB (
  InvIdB INT  PRIMARY KEY NOT NULL,
  Capacity INT NOT NULL
);

-- insert sample data into Inv Table
INSERT INTO INVB (InvIdB, Capacity)
VALUES 
  (3, 410);
  
-- Create table for Locations
CREATE TABLE LocationB(
  LocIdB INT  PRIMARY KEY NOT NULL,
  Address VARCHAR(200) NOT NULL,
  InvenId INT NOT NULL,
  FOREIGN KEY (InvenId) REFERENCES INVB(InvIdB)
);  

-- insert sample data into Location Table
INSERT INTO LocationB (LocIdB, Address , InvenId)
VALUES 
    (3, '789 Oak Boulevard',3)
    ; 
    
 -- Create table for Suppliers
CREATE TABLE SuppliersB (
  SuppIdB INT  PRIMARY KEY NOT NULL,
  phone VARCHAR(20) NOT NULL,
  Name VARCHAR(100) NOT NULL
);  

-- insert sample data into Suppliers Table
INSERT INTO SuppliersB (SuppIdB, Name, phone)
VALUES 
    (1, 'Mohamed', '069234'),        
    (2, 'Cleo Company','1478523'),         
    (3, 'Amin','852134'),
    (4, 'Sameh','999663322'),
    (5,'Oah Factory','5832145')
    ; 
    
CREATE TABLE TransactionB (
  TransIdB INT  PRIMARY KEY NOT NULL,
  TypeT VARCHAR(200) NOT NULL,
  INvID INT NOT NULL,
  SupID INT NOT NULL,
  FOREIGN KEY (INvID) REFERENCES INVB(InvIdB),
  FOREIGN KEY (SupID) REFERENCES SuppliersB(SuppIdB)
); 

-- insert sample data into Transaction Table
INSERT INTO TransactionB (TransIdB, TypeT,INvID,SupID)
VALUES 
    (1, 'Cash',3,2),        
    (2, 'Credit Card',3,1),         
    (3, 'Annual insatllment',3,3),
    (4, 'Cash',3,4),
    (5,'Credit Card',3,5)
    ; 
    
-- Create table for Products
CREATE TABLE ProductsB (
  ProIdB INT  PRIMARY KEY NOT NULL,
  BarCode VARCHAR(100) NOT NULL,
  PName VARCHAR(100) NOT NULL,
  Quantity INT NOT NULL
);  

-- insert sample data into Products Table
INSERT INTO ProductsB (ProIdB, PName, BarCode, Quantity)
VALUES 
    (1, 'Milk', '00005',1000),        
    (2, 'cheese','90000',540),         
    (3, 'Potato','88888',700)
    ;     
    
-- Create table for Orders
CREATE TABLE OrdersB (
  OrderIdB INT  PRIMARY KEY NOT NULL,
  OrderDate DATE NOT NULL,
  DeliveryDate DATE NOT NULL
);  

-- insert sample data into Orders Table
INSERT INTO OrdersB (OrderIdB , OrderDate, DeliveryDate)
VALUES 
    (1, '2023-08-01', '2023-08-15'),        
    (2, '2023-09-15','2023-09-17'),         
    (3, '2023-05-13','2023-05-19')
    ;
-- Create table for Provide relation
CREATE TABLE ProvideB (
  prodid INT NOT NULL,
  supid INT NOT NULL,
  PRIMARY KEY (prodid, supid),
  FOREIGN KEY (prodid) REFERENCES ProductsB(ProIdB),
  FOREIGN KEY (supid) REFERENCES SuppliersB(SuppIdB)
);  

-- Create table for Get relation
CREATE TABLE GetB (
  invid INT NOT NULL,
  proid INT NOT NULL,
  QuantityB INT NOT NULL,
  PRIMARY KEY (invid, proid, QuantityB),
  FOREIGN KEY (invid) REFERENCES INVB(InvIdB),
  FOREIGN KEY (proid) REFERENCES ProductsB(ProIdB)
);

-- insert sample data into Get Table
INSERT INTO GetB (invid, proid, QuantityB)
VALUES 
    (3, 2, 130),        
    (3, 1, 250),         
    (3, 3,190)
    ;

SELECT * FROM ProductB