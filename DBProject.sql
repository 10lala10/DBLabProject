CREATE DATABASE DBProject
GO

USE DBProject
GO

CREATE TABLE Customer (
	CustomerID		CHAR(5) NOT NULL,
	[Name]			VARCHAR(255),
	Email			VARCHAR(255),
	[Address]		VARCHAR(255),
	Date_of_Birth	VARCHAR(255),
	Gender			VARCHAR(255),
	PhoneNumber		VARCHAR(255),
	[Password]		VARCHAR(255),
	MoneyBalance	INTEGER
	
	CONSTRAINT PK_Customer PRIMARY KEY(CustomerID),
	CONSTRAINT Check_CustID CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CONSTRAINT Check_CustName CHECK([Name] LIKE '% %'),
	CONSTRAINT Check_CustGender CHECK(Gender LIKE 'Male' OR Gender LIKE 'Female'),
	CONSTRAINT Check_CustEmail CHECK(Email LIKE '%@%'),
	CONSTRAINT Check_CustNumber CHECK(LEN(PhoneNumber) = 12)
)
GO

CREATE TABLE DBMSSoftware(
	DBMSSoftwareID		CHAR(5) NOT NULL,
	[Name]				VARCHAR(255),
	[URL]				VARCHAR(255)
	
	CONSTRAINT PK_DBMSSoftware PRIMARY KEY(DBMSSoftwareID),
	CONSTRAINT Check_DBMS_ID CHECK(DBMSSoftwareID LIKE 'DS[0-9][0-9][0-9]')
)
GO

CREATE TABLE [Database](
	DatabaseID			CHAR(5)		NOT NULL,
	DBMSSoftwareID		CHAR(5)		NOT NULL,
	Storage				INT,
	Price				INT
	
	CONSTRAINT PK_Database PRIMARY KEY(DatabaseID),
	CONSTRAINT FK_Database FOREIGN KEY(DBMSSoftwareID) REFERENCES DBMSSoftware,
	CONSTRAINT Check_DB_ID CHECK(DBMSSoftwareID LIKE 'DB[0-9][0-9][0-9]'),
	CONSTRAINT Check_DB_Storage CHECK(Storage > 0)
)
GO

CREATE TABLE Operating_System (
	OperatingSystemID		CHAR(5) NOT NULL,
	[Name]					VARCHAR(255),
	Family					VARCHAR(255),
	Price					INTEGER

	CONSTRAINT PK_OperatingSystem PRIMARY KEY(OperatingSystemID),
	CONSTRAINT Check_OSID CHECK(OperatingSystemID LIKE 'OS[0-9][0-9][0-9]'),
	CONSTRAINT Check_OSPrice CHECK (Price >= 500000 AND Price <= 1500000)
)

GO

CREATE TABLE Processor(
	ProcessorID		CHAR(5) NOT NULL,
	[Name]			VARCHAR(255),
	Cores			INTEGER,
	BaseClockSpeed	INTEGER,
	BoostClockSpeed	INTEGER

	CONSTRAINT PK_Processor PRIMARY KEY(ProcessorID),
	CONSTRAINT Check_ProcessorID CHECK(ProcessorID LIKE 'PR[0-9][0-9][0-9]')

)

GO

CREATE TABLE [Server](
	ServerID			CHAR(5) NOT NULL,
	ProcessorID			CHAR(5) NOT NULL,
	OperatingSystemID	CHAR(5) NOT NULL,
	[Name]				VARCHAR(255),
	Memory				INTEGER,
	Price				INTEGER,
	Storage				INTEGER

	CONSTRAINT PK_Server PRIMARY KEY(ServerID),
	CONSTRAINT FK_Server1 FOREIGN KEY(ProcessorID) REFERENCES Processor,
	CONSTRAINT FK_Server2 FOREIGN KEY(OperatingSystemID) REFERENCES Operating_System,
	CONSTRAINT Check_ServerID CHECK(ServerID LIKE 'SV[0-9][0-9][0-9]'),
	CONSTRAINT Check_ServerMemory CHECK(Memory % 2 = 0),
	CONSTRAINT Check_ServerPrice CHECK(Price >= 10000 AND Price <= 300000)
)
GO

CREATE TABLE Cloud_Provider(
	CloudProviderID		CHAR(5) NOT NULL,
	[Name]				VARCHAR(255),
	Email				VARCHAR(255),
	Region				VARCHAR(255),
	[URL]				VARCHAR(255)

	CONSTRAINT PK_CloudProvider PRIMARY KEY(CloudProviderID),
	CONSTRAINT Check_ProviderID	CHECK(CloudProviderID LIKE 'CP[0-9][0-9][0-9]')
)	
GO

CREATE TABLE [Transaction](
	TransactionID	CHAR(5) NOT NULL,
	CustomerID		CHAR(5) NOT NULL,
	CloudProviderID	CHAR(5) NOT NULL,
	DatabaseID		CHAR(5) NOT NULL,
	ServerID		CHAR(5) NOT NULL,
	PaymentDate		DATE
	
	CONSTRAINT PK_Transaction PRIMARY KEY (TransactionID),
	CONSTRAINT FK_Transaction1 FOREIGN KEY (CustomerID) REFERENCES Customer,
	CONSTRAINT FK_Transaction2 FOREIGN KEY (CloudProviderID) REFERENCES Cloud_Provider,
	CONSTRAINT FK_Transaction3 FOREIGN KEY (DatabaseID) REFERENCES [Database],
	CONSTRAINT FK_Transaction4 FOREIGN KEY (ServerID) REFERENCES [Server],
	CONSTRAINT Check_TransactionID CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]')
)	

-- PROCEDURES --
CREATE PROCEDURE Input_Customer @name varchar(255), @email varchar(255), @address varchar(255), @date_of_birth date, @gender varchar(255), @phone_number varchar(255), @password varchar(255),  @customer_id char(5)
	as INSERT INTO Customer VALUES(@name , @email , @address , @date_of_birth, @gender, @phone_number ,@password, 0, @customer_id)

GO

-- PROCEDURES --

---- DROPS --
--DROP TABLE Customer
--DROP PROCEDURE Input_Customer
--DROP TABLE DBMSSoftware
---- DROPS --

---- SELECTS --
--select * from Customer
--SELECT LEN(PhoneNumber) FROM Customer
---- SELECTS --

--DROP DATABASE DBProject