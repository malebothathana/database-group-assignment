--question 1

--createing a database named bookstoredb
CREATE DATABASE bookstoredb

-- question 2

--determining the schemas and data types for the tables
book
- BookID (INT, PRIMARY KEY)
- Title (VARCHAR(255), NOT NULL)
- ISBN (VARCHAR(20), NOT NULL)
- Price (DECIMAL(10, 2), NOT NULL)
- PublisherID (INT)
- LanguageID (INT)

book_author
- BookID (INT, NOT NULL)
- AuthorID (INT, NOT NULL)

author
- AuthorID (INT, PRIMARY KEY)
- Name (VARCHAR(100), NOT NULL)
- Bio (TEXT)

book_language
- LanguageID (INT, PRIMARY KEY)
- LanguageName (VARCHAR(50), NOT NULL)

publisher
- PublisherID (INT, PRIMARY KEY)
- PublisherName (VARCHAR(100), NOT NULL)

Customer
- CustomerID (INT, PRIMARY KEY)
- Name (VARCHAR(100), NOT NULL)
- Email (VARCHAR(100), NOT NULL)

customer_address
- CustomerID (INT, NOT NULL)
- AddressID (INT, NOT NULL)

address_status
- StatusID (INT, PRIMARY KEY)
- StatusName (VARCHAR(50), NOT NULL)

address
- AddressID (INT, PRIMARY KEY)
- Street (VARCHAR(255), NOT NULL)
- City (VARCHAR(100), NOT NULL)
- CountryID (INT, NOT NULL)
- StatusID (INT, NOT NULL)

country
- CountryID (INT, PRIMARY KEY)
- CountryName (VARCHAR(100), NOT NULL)

cust_order
- OrderID (INT, PRIMARY KEY)
- CustomerID (INT, NOT NULL)
- OrderDate (DATE, NOT NULL)
- TotalCost (DECIMAL(10, 2), NOT NULL)
- ShippingMethodID (INT)

order_line
- OrderID (INT, NOT NULL)
- BookID (INT, NOT NULL)
- Quantity (INT, NOT NULL)

shipping_method
- ShippingMethodID (INT, PRIMARY KEY)
- ShippingMethodName (VARCHAR(100), NOT NULL)

order_history
- OrderID (INT, NOT NULL)
- StatusID (INT, NOT NULL)
- UpdateDate (DATE, NOT NULL)

order_status
- StatusID (INT, PRIMARY KEY)
- StatusName (VARCHAR(50), NOT NULL)


-- question 3

--writing the SQL commands to create the tables thatbmatch the data structure
USE bookstoredb;

CREATE TABLE book (
  BookID INT PRIMARY KEY,
  Title VARCHAR(100) NOT NULL,
  ISBN VARCHAR(20) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  PublisherID INT,
  LanguageID INT
);

CREATE TABLE book_author (
  BookID INT NOT NULL,
  AuthorID INT NOT NULL,
  PRIMARY KEY (BookID, AuthorID)
);

CREATE TABLE author (
  AuthorID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Bio TEXT
);

CREATE TABLE book_language (
  LanguageID INT PRIMARY KEY,
  LanguageName VARCHAR(50) NOT NULL
);

CREATE TABLE publisher (
  PublisherID INT PRIMARY KEY,
  PublisherName VARCHAR(100) NOT NULL
);

CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL
);

CREATE TABLE customer_address (
  CustomerID INT NOT NULL,
  AddressID INT NOT NULL,
  PRIMARY KEY (CustomerID, AddressID)
);

CREATE TABLE address_status (
  StatusID INT PRIMARY KEY,
  StatusName VARCHAR(50) NOT NULL
);

CREATE TABLE address (
  AddressID INT PRIMARY KEY,
  Street VARCHAR(100) NOT NULL,
  City VARCHAR(100) NOT NULL,
  CountryID INT NOT NULL,
  StatusID INT NOT NULL
);

CREATE TABLE country (
  CountryID INT PRIMARY KEY,
  CountryName VARCHAR(100) NOT NULL
);

CREATE TABLE cust_order (
  OrderID INT PRIMARY KEY,
  CustomerID INT NOT NULL,
  OrderDate DATE NOT NULL,
  TotalCost DECIMAL(10, 2) NOT NULL,
  ShippingMethodID INT
);

CREATE TABLE order_line (
  OrderID INT NOT NULL,
  BookID INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (OrderID, BookID)
);

CREATE TABLE shipping_method (
  ShippingMethodID INT PRIMARY KEY,
  ShippingMethodName VARCHAR(100) NOT NULL
);

CREATE TABLE order_history (
  OrderID INT NOT NULL,
  StatusID INT NOT NULL,
  UpdateDate DATE NOT NULL,
  PRIMARY KEY (OrderID, StatusID)
);

CREATE TABLE order_status (
  StatusID INT PRIMARY KEY,
  StatusName VARCHAR(50) NOT NULL
);

ALTER TABLE book
ADD CONSTRAINT fk_book_publisher FOREIGN KEY (PublisherID) REFERENCES publisher(PublisherID),
ADD CONSTRAINT fk_book_language FOREIGN KEY (LanguageID) REFERENCES book_language(LanguageID);


--question 4

--setting up user groups and roles to control access to the database

-- Grant privileges to roles
GRANT ALL PRIVILEGES ON bookstoredb.* TO admin;
GRANT SELECT, INSERT, UPDATE ON bookstoredb.* TO manager;
GRANT SELECT ON bookstoredb.* TO customer;

-- Create users and assign them to roles
CREATE USER 'admin_user'@'%' IDENTIFIED BY 'password1';
GRANT admin TO 'admin_user'@'%';

CREATE USER 'manager_user'@'%' IDENTIFIED BY 'password2';
GRANT manager TO 'manager_user'@'%';

CREATE USER 'customer_user'@'%' IDENTIFIED BY 'password3';
GRANT customer TO 'customer_user'@'%';





