import mysql.connector

def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='username',
            password='password',
            database='inventory_db'
        )
        if connection.is_connected():
            print('Connected to MySQL database')
            return connection
    except mysql.connector.Error as e:
        print('Error connecting to MySQL:', e)
        return None

def update_price(product_id, new_price):
    try:
        cursor = connection.cursor()
        # Update price in the database
        cursor.execute('UPDATE products SET price = %s WHERE product_id = %s', (new_price, product_id))
        connection.commit()
        print('Price updated successfully')
    except mysql.connector.Error as e:
        print('Error updating price:', e)
    finally:
        cursor.close()

# Close the connection
def close_connection():
    if connection.is_connected():
        connection.close()
        print('Connection closed')