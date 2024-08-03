# Product Inventory Management System

![License](https://img.shields.io/github/license/AlgoArchives/Product-Inventory-Management-System)
![Issues](https://img.shields.io/github/issues/AlgoArchives/Product-Inventory-Management-System)
![Forks](https://img.shields.io/github/forks/AlgoArchives/Product-Inventory-Management-System)
![Stars](https://img.shields.io/github/stars/AlgoArchives/Product-Inventory-Management-System)

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Introduction

The **Product Inventory Management System** is a web application designed to help businesses manage their product inventory efficiently. It provides a user-friendly interface for searching products, managing stock levels, and processing purchases.

## Features

- **Product Search**: Easily search for products by name or description.
- **Buy Products**: Purchase products and update inventory quantities.
- **Inventory Management**: Track and manage product details, quantities, and categories.
- **User Authentication**: Secure login system for users.

## Technology Stack

- **Frontend**: HTML, CSS, JavaScript, Bootstrap
- **Backend**: Flask
- **Database**: MySQL
- **Other**: jQuery, AJAX

## Installation

Follow these steps to set up the project on your local machine:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/AlgoArchives/Product-Inventory-Management-System.git
    cd Product-Inventory-Management-System
    ```

2. **Set up the virtual environment**:
    ```bash
    python3 -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. **Install backend dependencies**:
    ```bash
    pip install -r requirements.txt
    ```

4. **Set up the database**:
    - Create a MySQL database.
    - Import the database schema provided in the `main.sql` file:
        ```sql
        mysql -u your_username -p your_database_name < main.sql
        ```

5. **Configure the backend**:
    - Update the database configuration in `app.py` and `db_connection.py` with your database credentials:
        ```python
        connection = mysql.connector.connect(
            host='localhost',
            user='your_username',
            password='your_password',
            database='inventory_db'
        )
        ```

6. **Run the application**:
    ```bash
    python app.py
    ```

7. **Access the application**:
    Open your browser and navigate to `http://localhost:5000`.

## Usage

1. **Search Products**: Use the search bar to find products by name or description.
2. **Buy Products**: Click the "Buy" button on a product card, fill in the quantity, and confirm the purchase.
3. **Manage Inventory**: Use the provided stored procedures to add, update, or delete products in the database.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.