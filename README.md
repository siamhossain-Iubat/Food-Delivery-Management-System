# food-delivery-management-system-sql
<h1>Project Overview</h1>

The Food Delivery Management System (FDMS) is a robust database solution designed to connect customers, vendors (restaurants), and delivery riders. This project focuses on automating order processing, ensuring data accuracy, and managing financial transactions like payments and rider commissions.

================================ Objectives =================================

=>Efficiency: Automate and streamline order processing and delivery operations.

=>Data Accuracy: Ensure reliable, validated data entry with minimal redundancy using constraints and triggers.

=>Customer Experience: Facilitate smooth interaction between customers, vendors, and riders.

=>Financial Management: Accurately track sales, customer payments, and rider commissions.

=>Analytics: Provide insights through reporting on vendor sales and rider performance.

================================ ER Diagram (Core Entities) =========================
The system is built on a relational schema with the following primary entities:

=> Customers: Stores personal details and contact information.

=> Vendors: Management of restaurant/shop details.

=> Menu Items: Linked to vendors, containing food items and pricing.

=> Orders: The central entity connecting customers and items.

=> Riders: Delivery personnel information and availability.

=> Payments: Records of transactions and payment status.

=> Reviews: Feedback system for orders.

Hare is a clean ER Diagram picture for understanding the relationships between the Tables
<img width="887" height="558" alt="FDMS ER_Diagram" src="https://github.com/user-attachments/assets/0165fcfd-36cf-4718-928c-d15c6ab2f538" />

========================= Business Requirements ==============================

Based on the case study, the database satisfies the following business logic:

=> Customer Order Management: Customers can browse menus and place orders.

=> Rider Assignment: Orders are assigned to riders with built-in payment validation.

=> Vendor Operations: Vendors can manage their own menus and track sales.

=> Automated Updates: Using Triggers, the system automatically updates order dates when the status changes to 'DELIVERED'.

=> Data Integrity: Implemented via Primary Keys, Foreign Keys, and Sequences (e.g., sqCusmtomerID).

=> Reporting: Complex Views (like vTopTenPaybleOrders) and Stored Procedures are used for administrative reporting.

======================== Technical Features ==========================

=> DDL (Data Definition Language): Comprehensive schema design including Tables, Schemas, and Constraints.

=> DML (Data Manipulation Language): Advanced data operations including Transaction management (BEGIN TRANSACTION, TRY...CATCH).

=> Programmability: Extensive use of:

1. Stored Procedures: For secure data insertion and deletion.

2. User-Defined Functions (UDF): For calculating totals and fetching specific data.

3. Triggers: For maintaining real-time data consistency.

=============================== How to Use ============================

Run the 1291163 DDL.sql file to create the database schema and objects.

Run the 1291163_DML.sql file to populate the tables with sample data and test the logic.

Trainee Details
Name: Abdul Mazed

Trainee ID: 1291163

Batch: CS/PNTL-A/67/01

Instructor: MD AZMAN ALI

Consultant: Syed Zahidul Hassan
