from flask import Flask, render_template, request, jsonify
from db_connection import connect_to_database, close_connection
import mysql.connector

app = Flask(__name__)

# Connect to MySQL database
connection = mysql.connector.connect(
    host='localhost',
    user='username',
    password='password',
    database='inventory_db'
)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/search', methods=['POST'])
def search_products():
    search_term = request.form.get('searchInput')
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM products WHERE name LIKE %s OR description LIKE %s", ('%' + search_term + '%', '%' + search_term + '%'))
    products = cursor.fetchall()
    return jsonify(products)

@app.route('/buy', methods=['POST'])
def buy_product():
    product_id = request.form.get('productId')
    quantity = int(request.form.get('quantityInput'))
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM products WHERE product_id = %s", (product_id,))
    product = cursor.fetchone()
    if product['quantity'] >= quantity:
        # Update product quantity and perform buying logic (e.g., add order to database)
        cursor.execute("UPDATE products SET quantity = quantity - %s WHERE product_id = %s", (quantity, product_id))
        connection.commit()
        return jsonify({'success': True, 'message': 'Product bought successfully!'})
    else:
        return jsonify({'success': False, 'message': 'Insufficient quantity!'})

if __name__ == '__main__':
    app.run(debug=True)