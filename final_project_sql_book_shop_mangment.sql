CREATE DATABASE BookStore_project;
USE BookStore_project;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Bio VARCHAR(500)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT NOT NULL,
    Genre VARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT DEFAULT 0 NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublicationYear CHAR(4) NOT NULL, 
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY, 
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    ShippingAddress VARCHAR(500)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE DEFAULT GETDATE() NOT NULL,
    ShippingDate DATE,
    OrderStatus VARCHAR(20) DEFAULT 'Pending' NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    BookID INT NOT NULL,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY, 
    OrderID INT NOT NULL,
    PaymentAmount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE DEFAULT GETDATE() NOT NULL,
    PaymentMethod VARCHAR(50) DEFAULT 'Cash' NOT NULL, 
    PaymentStatus VARCHAR(20) DEFAULT 'Pending' NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);



--TASK 2 START HERE

INSERT INTO Authors (AuthorID, FirstName, LastName, Bio)
VALUES 
(1, 'J.K.', 'Rowling', 'Author of the Harry Potter series.'),
(2, 'George', 'Orwell', 'Famous for "1984" and "Animal Farm".'),
(3, 'Agatha', 'Christie', 'Known for detective novels.');

INSERT INTO Books (BookID, Title, AuthorID, Genre, Price, StockQuantity, ISBN, PublicationYear)
VALUES 
(1, 'Harry Potter and the Sorcerer`s Stone', 1, 'Fantasy', 19.99, 100, '9780747532699', '1997'),
(2, '1984', 2, 'Dystopian', 15.50, 50, '9780451524935', '1949'),
(3, 'Murder on the Orient Express', 3, 'Mystery', 12.99, 75, '9780062693662', '1934'),
(4, 'Animal Farm', 2, 'Political Satire', 10.99, 60, '9780451526342', '1945'),
(5, 'The Casual Vacancy', 1, 'Drama', 14.99, 120, '9781408704202', '2012'),
(6, 'Shadows of the Past', 2, 'Mystery', 18.50, 200, '9781234567890', '2019')

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, ShippingAddress)
VALUES 
(1, 'Alice', 'Johnson', 'alice.johnson@email.com', '555-1234', '123 Elm Street, Springfield, IL 62701'),
(2, 'Bob', 'Smith', 'bob.smith@email.com', '555-5678', '456 Oak Avenue, Chicago, IL 60601'),
(3, 'Charlie', 'Brown', 'charlie.brown@email.com', '555-8765', '789 Pine Road, Decatur, IL 62521'),
(4, 'David', 'Taylor', 'david.taylor@email.com', '555-4321', '101 Maple Lane, Urbana, IL 61801'),
(5,'Michael', 'Smith', 'michael.smith@email.com', '555-5678', '456 Oak Avenue, Denver, CO 80203')


INSERT INTO Orders (OrderID, CustomerID, OrderDate, ShippingDate, OrderStatus)
VALUES 
(1, 1, '2025-01-15', '2025-01-20', 'Shipped'),
(2, 2, '2025-01-16', '2025-01-21', 'Shipped'),
(3, 3, '2025-01-17', '2025-01-22', 'Pending'),
(4, 4, '2025-01-18', '2025-01-23', 'Shipped'),
(5, 1, '2025-01-19', '2025-01-24', 'Pending');


INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity, Subtotal)
VALUES 
(1, 1, 1, 2, 39.98), 
(2, 2, 3, 1, 12.99),  
(3, 3, 2, 3, 46.50),  
(4, 4, 4, 2, 21.98),  
(5, 5, 5, 2, 29.98);  


INSERT INTO Payments (PaymentID, OrderID, PaymentAmount, PaymentDate, PaymentMethod, PaymentStatus)
VALUES
(1, 1, 52.97, '2025-01-15', 'Credit Card', 'Completed'),
(2, 2, 68.48, '2025-01-16', 'PayPal', 'Completed'),
(3, 3, 27.98, '2025-01-17', 'Credit Card', 'Pending'),
(4, 4, 35.49, '2025-01-18', 'Debit Card', 'Completed'),
(5, 5, 29.98, '2025-01-19', 'Cash', 'Pending');

--TASK 3 STARTS HERE
UPDATE Books
SET StockQuantity = StockQuantity - OD.Quantity
FROM Books AS B
JOIN OrderDetails AS OD ON B.BookID = OD.BookID
WHERE OD.OrderID = 3; 


UPDATE Customers
SET ShippingAddress = '505 Aspen Boulevard, Phoenix, AZ 85001'
WHERE CustomerID = 2;


DELETE FROM Orders
WHERE OrderID = 1;

--TASK 4 START HERE

SELECT * FROM Books
SELECT Title,Genre,Price,StockQuantity FROM Books

SELECT 
    O.OrderID,
    B.Title AS BookTitle,
    OD.Quantity,
    O.OrderDate,
    O.OrderStatus
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Books B ON OD.BookID = B.BookID
WHERE O.CustomerID = 1; 

SELECT 
    P.PaymentID,
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    O.OrderDate,
    P.PaymentAmount,
    P.PaymentMethod
FROM Payments P
JOIN Orders O ON P.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID;

--TASK 5 START HERE
SELECT SUM(OD.Subtotal) AS TotalRevenue
FROM OrderDetails AS OD
JOIN Orders AS O ON OD.OrderID=O.OrderID
WHERE O.OrderDate BETWEEN '2025-01-01' AND '2025-01-31'

SELECT C.CustomerID, 
       CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
       SUM(OD.Quantity) AS TotalBooksPurchased
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.FirstName, C.LastName;


SELECT B.Genre,
	   SUM(OD.Quantity)AS TOTAL_BOOKS_SOLD
FROM Books AS B
JOIN OrderDetails AS OD ON B.BookID = OD.BookID
GROUP BY B.Genre

--TASK 6 STARTS HERE

SELECT O.OrderID, CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, B.Title , OD.Quantity, O.OrderDate, P.PaymentStatus
FROM ORDERS AS  O
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
INNER JOIN Books AS B ON OD.BookID = B.BookID
INNER JOIN Payments AS P ON O.OrderID = P.OrderID
GROUP BY O.OrderID , C.FirstName, C.LastName,B.Title, OD.Quantity, O.OrderDate, P.PaymentStatus


SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
	   C.Email, 
       C.Phone, 
       C.ShippingAddress
FROM Customers AS C 
LEFT JOIN Orders AS O ON   O.CustomerID =  C.CustomerID
WHERE O.OrderID IS NULL;



SELECT B.Title, B.Genre ,B.Price,B.PublicationYear
FROM OrderDetails AS OD
RIGHT JOIN BOOKS AS B ON OD.BookID = B.BookID
WHERE OD.OrderID IS NULL;

--TASK 7 START HERE
GO
CREATE PROCEDURE CREATE_ORDER
	@OrderDetailID INT, 
	@OrderID INT, 
	@CustomerID INT, 
	@OrderDate DATE , 
	@ShippingDate DATE, 
	@OrderStatus VARCHAR(20),
	@BookID INT, 
	@Quantity INT
AS
BEGIN 
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ShippingDate, OrderStatus)
VALUES (@OrderID, @CustomerID, @OrderDate, @ShippingDate, @OrderStatus)

INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity, Subtotal)
VALUES (@OrderDetailID, @OrderID, @BookID, @Quantity, (SELECT Price FROM Books WHERE BookID = @BookID)*@Quantity)
END
GO

EXEC CREATE_ORDER 
	@OrderDetailID = 6, 
	@OrderID =6, 
	@CustomerID =5, 
	@OrderDate = '2025-12-26' , 
	@ShippingDate= '2025-01-20', 
	@OrderStatus= 'Shipped',
	@BookID= 6,
	@Quantity = 23


SELECT 
    O.OrderID,
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    SUM(OD.Subtotal) AS TotalPrice,
    CASE 
        WHEN SUM(OD.Subtotal) > 100 THEN SUM(OD.Subtotal) * 0.90  
        ELSE SUM(OD.Subtotal)  
    END AS DiscountedPrice
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY O.OrderID, C.FirstName, C.LastName;



GO
CREATE PROCEDURE ADD_ORDER_IF_IN_STOCK
    @OrderDetailID INT, 
    @OrderID INT, 
    @CustomerID INT, 
    @OrderDate DATE, 
    @ShippingDate DATE, 
    @OrderStatus VARCHAR(20),
    @BookID INT, 
    @Quantity INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID AND StockQuantity >= @Quantity)
    BEGIN
        INSERT INTO Orders (OrderID, CustomerID, OrderDate, ShippingDate, OrderStatus)
        VALUES (@OrderID, @CustomerID, @OrderDate, @ShippingDate, @OrderStatus);

        INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity, Subtotal)
        VALUES (@OrderDetailID, @OrderID, @BookID, @Quantity, 
               (SELECT Price FROM Books WHERE BookID = @BookID) * @Quantity);

        UPDATE Books
        SET StockQuantity = StockQuantity - @Quantity
        WHERE BookID = @BookID;
     END
END
GO

EXEC CREATE_ORDER 
	@OrderDetailID = 7, 
	@OrderID =7, 
	@CustomerID =5, 
	@OrderDate = '2025-12-26' , 
	@ShippingDate= '2025-01-20', 
	@OrderStatus= 'Shipped',
	@BookID= 6,
	@Quantity = 6



--TASK 8 START HERE

CREATE VIEW OrderReport AS
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName , B.Title, O.OrderDate, P.PaymentAmount, P.PaymentStatus
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Books AS B ON OD.BookID = B.BookID
JOIN Payments AS P ON OD.OrderID = P.OrderID


SELECT * 
FROM OrderReport
ORDER BY OrderDate;