
DROP TABLE Customers
DROP TABLE Properties


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
,   Zip_Code            NUMBER
,   Phone_Number        NUMBER
,   CONSTRAINT PKCust   PRIMARY KEY (Cust_ID)
,   CONSTRAINT CKState  CHECK (State IN ('NY', 'NJ', 'PA'))
);

CREATE TABLE Properties
(
    Listing_ID           NUMBER
,   Cust_ID              NUMBER
,   Listing_Date         DATE
,   Price                NUMBER NOT NULL
,   Num_Bedrooms         NUMBER
,   Num_Baths            NUMBER
,   Square_Feet          NUMBER
,   Street_Address      VARCHAR2(20)
,   City                VARCHAR2(20)
,   State               CHAR(2)
,   Zip_Code            NUMBER NOT NULL
,   CONSTRAINT FKProp   FOREIGN KEY (Cust_ID) REFERENCES Customers
);

CREATE SEQUENCE Cust_seq 
    START WITH 705 
    INCREMENT BY 1;

CREATE SEQUENCE Prop_seq
    START WITH 1007
    INCREMENT BY 1;