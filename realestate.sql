
DROP TABLE Customers;
DROP TABLE Properties;

DROP SEQUENCE Cust_seq;
DROP SEQUENCE Prop_seq;


CREATE TABLE Customers
(
    Cust_ID             NUMBER
,   First               VARCHAR2(15)
,   Last                VARCHAR2(15)
,   DOB                 DATE
,   Gender              CHAR(1)
,   Street_Address      VARCHAR2(20)
,   City                VARCHAR2(20)
,   State               CHAR(2)
,   Zip_Code            VARCHAR2(5) NOT NULL
,   Phone_Number        VARCHAR2(12)
,   CONSTRAINT PKCust   PRIMARY KEY (Cust_ID)
,   CONSTRAINT CKState  CHECK (State IN ('NY', 'NJ', 'PA'))
);

CREATE TABLE Properties
(
    List_ID              NUMBER
,   Cust_ID              NUMBER
,   Listing_Date         DATE
,   Price                NUMBER NOT NULL
,   Num_Bedrooms         NUMBER
,   Num_Baths            NUMBER
,   Square_Feet          NUMBER
,   Street_Address       VARCHAR2(20)
,   City                 VARCHAR2(20)
,   State                CHAR(2)
,   Zip_Code             VARCHAR2(5) NOT NULL
,   CONSTRAINT PK_Property  PRIMARY KEY (List_ID)
,   CONSTRAINT FKProp    FOREIGN KEY (Cust_ID) REFERENCES Customers
,   CONSTRAINT UK_Property  UNIQUE  (Street_Address, City, State, Zip_Code)
=======
,   Zip_Code             NUMBER NOT NULL
,   CONSTRAINT FKProp    FOREIGN KEY (Cust_ID) REFERENCES Customers
);

CREATE SEQUENCE Cust_seq 
    START WITH 705 
    INCREMENT BY 1;

CREATE SEQUENCE Prop_seq
    START WITH 1007
    INCREMENT BY 1;

 -- Test State Constraint
-- INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) VALUES(Customer_Seq.nextval, 'Kevin', 'Wood', '28-Apr-1993', 'M', '1018 Brushy Mountain Road', 'Stuart', 'VA', '24171', '276-555-1234');

-- Test NOT NULL Zipcode
-- INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State) VALUES(Property_Seq.nextval, 705, '6-May-2021', 150000, 2, 2.5, 4500, '1212 18th St', 'New York', 'NY');

-- Test NOT NULL Price
-- INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 706, '4-May-2021', 7, 6.5, 10700, '123 ABC Street', 'New York', 'NY', '10037');

INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone)
VALUES(Customer_Seq.nextval, 'Mike', 'Logan', '13-Nov-1954', 'M', '901 Main St', 'New York', 'NY', '10029', '212-555-1212');

INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) 
VALUES(Customer_Seq.nextval, 'Lennie', 'Brisco', '20-Oct-1935', 'M', '1212 9th St', 'New York', 'NY', '10037', '212-345-8957');

INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) 
VALUES(Customer_Seq.nextval, 'Claire', 'Kincaid', '25-Nov-1968', 'F', '116 Cedar St', 'Millville', 'NJ', '08332', '856-327-0847');

INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) 
VALUES(Customer_Seq.nextval, 'Jack', 'McCoy', '15-Nov-1940', 'M', '366 Orange Rd', 'Albany', 'NY', '12206', '518-432-4599');

INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) 
VALUES(Customer_Seq.nextval, 'Nora', 'Lewin', '28-Mar-1948', 'F', '1158 Kennedy Blvd', 'Bayonne', 'NJ', '07002', '856-339-0873');

INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) 
VALUES(Property_Seq.nextval, 706, '3-May-2021', 1299000, 5, 4, 3700, '1212 9th St', 'New York', 'NY', '10037');

INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode)
VALUES(Property_Seq.nextval, 708, '27-Apr-2021', 749000, 4, 2.5, 2200, '366 Orange Rd', 'Albany', 'NY', '12206');

INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) 
VALUES(Property_Seq.nextval, 705, '21-May-2021', 299000, 3, 2, 1750, '901 Main St', 'New York', 'NY', '10029');


