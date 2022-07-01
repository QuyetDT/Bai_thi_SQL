CREATE DATABASE AZBank
GO

USE AZBank
GO

CREATE TABLE Customer (
	CustomerId int PRIMARY KEY,
	Name NVARCHAR (50),
	City NVARCHAR(50),
	Country NVARCHAR(50),
	Phone NVARCHAR (15),
	Email NVARCHAR (50)
)
GO

--DROP TABLE CustomerAccount
CREATE TABLE CustomerAccount (
	AccountNumber CHAR (9) PRIMARY KEY,
	CustomerId INT CONSTRAINT fk1 FOREIGN KEY (CustomerId) REFERENCES Customer (CustomerId),
	Balance MONEY NOT NULL,
	MinAccount MONEY
)
GO
--DROP TABLE CustomerTransaction
CREATE TABLE CustomerTransaction (
	TransactionID INT PRIMARY KEY,
	AccountNumber CHAR (9) CONSTRAINT fk2 FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount (AccountNumber),
	TransactionDate smalldatetime,
	Amount MONEY,
	DepositorWithdraw bit --1: Depositor,  2: Withdraw
)
GO

INSERT INTO Customer (CustomerId, Name, City, Country, Phone, Email)
VALUES
(111, N'Đào Trọng Quyết', N'Thái Nguyên', N'Việt Nam', '0986476656', 'quyetdt@gmail.com'),
(222, N'Nguyễn Duy Khương', N'Hà Nội', N'Việt Nam', '0985462186', 'khuongnd@gmail.com'),
(333, N'Lê Thanh Huyền', N'Hà Nam', N'Việt Nam', '0389453214', 'huyenlt@gmail.com'),
(444, N'Võ Hồng Thương', N'Hà Tĩnh', N'Việt Nam', '0977564114', 'thuongvh@gmail.com'),
(555, N'Trần Quốc Tuấn', N'Hà Nội', N'Việt Nam', '0868543221', 'tuantq@gmail.com')
GO

INSERT INTO CustomerAccount (AccountNumber, CustomerId, Balance, MinAccount)
VALUES
('S2239487Z', 222, 2100, 100),
('M7736485B', 333, 5600, 100),
('L8493846M', 555, 7200, 100),
('T8873662Q', 111, 10600, 100),
('X9948732M', 444, 25500, 100)
GO

INSERT INTO CustomerTransaction (TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES
(34, 'M7736485B', '2022-05-19', 1000, '1'),
(86, 'L8493846M', '2022-04-19', 500, '0'),
(52, 'T8873662Q', '2022-03-19', 800, '1'),
(15, 'X9948732M', '2022-02-19', 250, '1'),
(97, 'S2239487Z', '2022-01-19', 1580, '0')
GO

SELECT * FROM Customer WHERE City = N'Hà Nội'
GO

SELECT Name, Phone, Email, AccountNumber, Balance
FROM Customer
full join CustomerAccount ON Customer.CustomerId = CustomerAccount.CustomerId
GO

ALTER TABLE CustomerTransaction ADD CONSTRAINT ck_money CHECK (Amount >0 AND Amount <= 1000000)
GO

CREATE VIEW vCustomerTransactions AS
SELECT Name, CustomerAccount.AccountNumber, TransactionDate, Amount, DepositorWithdraw
FROM Customer
	join CustomerAccount ON Customer.CustomerId = CustomerAccount.CustomerId
	join CustomerTransaction ON CustomerAccount.AccountNumber = CustomerTransaction.AccountNumber
GO

SELECT * FROM vCustomerTransactions