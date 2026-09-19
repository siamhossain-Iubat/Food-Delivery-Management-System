
# Food Delivery Management System (FDMS)

A robust SQL database solution designed to connect customers, vendors (restaurants), and delivery riders. This project focuses on automating order processing, maintaining data accuracy, and managing financial transactions such as customer payments and rider commissions.

## Project Overview

The Food Delivery Management System (FDMS) is designed to support the core operations of a food delivery platform. It manages customer orders, restaurant menus, rider assignments, payments, reviews, and business reporting through a relational database.

## Objectives

- **Operational Efficiency:** Automate and streamline order processing and delivery operations.
- **Data Accuracy:** Maintain reliable data with constraints, triggers, and reduced data redundancy.
- **Customer Experience:** Support interactions between customers, vendors, and delivery riders.
- **Financial Management:** Track sales, customer payments, and rider commissions.
- **Analytics:** Provide insights into vendor sales and rider performance through reporting.

## ER Diagram

The database is organized around the following core entities:

- **Customers:** Stores customer details and contact information.
- **Vendors:** Maintains restaurant and shop information.
- **Menu Items:** Stores food items and pricing associated with vendors.
- **Orders:** Represents customer orders and connects order-related records.
- **Riders:** Stores delivery personnel information and availability.
- **Payments:** Records payment transactions and their status.
- **Reviews:** Maintains customer feedback related to orders.

The following ER diagram illustrates the relationships between the core database tables.

<img width="887" height="558" alt="FDMS ER_Diagram" src="https://github.com/user-attachments/assets/0165fcfd-36cf-4718-928c-d15c6ab2f538" />

## Business Requirements

The database supports the following business requirements based on the project case study:

### Customer Order Management
Customers can browse menus and place food orders.

### Rider Assignment
Orders can be assigned to riders, with payment validation included in the process.

### Vendor Operations
Vendors can manage their menus and track sales.

### Automated Updates
Triggers automatically update order dates when the order status changes to `DELIVERED`.

### Data Integrity
Primary keys, foreign keys, constraints, and sequences help maintain data integrity. An example sequence is `sqCusmtomerID`.

### Reporting
Views, including `vTopTenPaybleOrders`, and stored procedures support administrative reporting.

## Technical Features

### DDL (Data Definition Language)
- Database schema design
- Table and schema creation
- Primary key and foreign key constraints
- Database object definitions

### DML (Data Manipulation Language)
- Data insertion and modification
- Data deletion operations
- Transaction management using `BEGIN TRANSACTION` and `TRY...CATCH`

### SQL Programmability

The project uses the following SQL Server programmability features:

1. **Stored Procedures:** Support secure data insertion and deletion operations.
2. **User-Defined Functions (UDFs):** Calculate totals and retrieve specific data.
3. **Triggers:** Help maintain data consistency through automated updates.
4. **Views:** Provide reusable queries for reporting and data analysis.
5. **Sequences:** Support identifier generation.

## Technology Stack

- **Database:** Microsoft SQL Server
- **Query Language:** Transact-SQL (T-SQL)
- **Database Tool:** SQL Server Management Studio (SSMS)

## How to Use

### Prerequisites

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)

### Setup Instructions

1. Clone or download this repository.
2. Open SQL Server Management Studio and connect to your SQL Server instance.
3. Open the `1291163 DDL.sql` file.
4. Execute the DDL script to create the database schema and database objects.
5. Open the `1291163_DML.sql` file.
6. Execute the DML script to populate the tables with sample data and test the database logic.

> Make sure to execute the scripts in the appropriate order and select the correct database context before running them.

## Project Files

| File | Description |
|---|---|
| `1291163 DDL.sql` | Creates the database schema and objects |
| `1291163_DML.sql` | Inserts sample data and tests database operations |
| `1291163_case_Study.pdf` | Project case study and requirements |

## Project Information

| Item | Details |
|---|---|
| Project | Food Delivery Management System |
| Developer | Siam Hossain |
| Project Type | SQL Database Project |
| Database | Microsoft SQL Server |

## License

Refer to the `LICENSE` file included in this repository.

---

Developed by **Siam Hossain**.
