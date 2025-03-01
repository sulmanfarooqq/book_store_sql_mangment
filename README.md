# book_store_sql_mangment
This SQL script is for a Bookstore Management System, and it contains multiple tasks involving database creation, data insertion, updates, deletions, queries, stored procedures, and views. Below is a breakdown of the tasks performed in this script:

TASK 1: Database and Table Creation
Creates a database called BookStore_project and selects it for use.
Creates six tables:
Authors: Stores author details.
Books: Stores book details (linked to Authors via AuthorID).
Customers: Stores customer information.
Orders: Stores order records (linked to Customers via CustomerID).
OrderDetails: Stores details of each order (linked to Orders and Books).
Payments: Stores payment records (linked to Orders).
TASK 2: Data Insertion
Inserts sample records into all tables:
Authors: 3 authors added.
Books: 6 books added.
Customers: 5 customers added.
Orders: 5 orders added.
OrderDetails: Details for 5 orders added.
Payments: 5 payments added.
TASK 3: Data Modification
Updates book stock after an order is placed (OrderID = 3).
Updates customer shipping address (CustomerID = 2).
Deletes an order (OrderID = 1).
TASK 4: Data Retrieval
Retrieves all books.
Retrieves specific book details (Title, Genre, Price, StockQuantity).
Retrieves order details for a specific customer (CustomerID = 1).
Retrieves payment details including customer names.
TASK 5: Analytical Queries
Calculates total revenue from all orders in January 2025.
Finds the total number of books purchased by each customer.
Finds the total number of books sold per genre.
TASK 6: Joins & Reports
Retrieves full order details, including customer name, book title, quantity, order date, and payment status.
Finds customers who have never placed an order.
Finds books that have never been sold.
TASK 7: Stored Procedures
Creates a stored procedure CREATE_ORDER to insert a new order and update order details.
Executes the procedure CREATE_ORDER with specific order details.
Retrieves orders with a discount calculation (applies a 10% discount for orders above $100).
Creates a stored procedure ADD_ORDER_IF_IN_STOCK to insert an order only if the requested book is in stock.
Executes the ADD_ORDER_IF_IN_STOCK procedure.
TASK 8: Creating a View
Creates a view OrderReport, which retrieves customer names, book titles, order dates, payment amounts, and payment statuses.
Retrieves all data from the OrderReport view, ordered by OrderDate.
Summary of Tasks
✅ Database & Table Creation
✅ Data Insertion
✅ Updating, Deleting, and Modifying Data
✅ Data Retrieval Queries
✅ Advanced Queries using Joins
✅ Stored Procedures for Automated Order Handling
✅ View Creation for Reporting

This script essentially sets up a full-fledged Bookstore Management System, enabling database operations such as order processing, stock management, and financial transactions.