// Fetch products from the database (mock data)
const products = [
    { id: 1, name: 'Laptop', description: 'High-performance laptop', price: 1200, quantity: 10 },
    { id: 2, name: 'T-shirt', description: 'Cotton t-shirt', price: 20, quantity: 50 },
    { id: 3, name: 'Python Programming Book', description: 'Introduction to Python programming', price: 35, quantity: 30 }
];

// Display products on page load
function displayProducts() {
    const productList = document.getElementById('productList');
    productList.innerHTML = ''; // Clear previous content
    products.forEach(product => {
        const card = document.createElement('div');
        card.className = 'col-md-4 mb-3';
        card.innerHTML = `
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">${product.name}</h5>
                    <p class="card-text">${product.description}</p>
                    <p class="card-text">Price: $${product.price}</p>
                    <p class="card-text">Quantity: ${product.quantity}</p>
                    <button class="btn btn-primary buy-btn" data-id="${product.id}" data-name="${product.name}" data-price="${product.price}" data-toggle="modal" data-target="#buyModal">Buy</button>
                </div>
            </div>
        `;
        productList.appendChild(card);
    });
}

// Handle search form submission
document.getElementById('searchForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Prevent default form submission
    const searchInput = document.getElementById('searchInput').value.trim().toLowerCase();
    const filteredProducts = products.filter(product =>
        product.name.toLowerCase().includes(searchInput) ||
        product.description.toLowerCase().includes(searchInput)
    );
    // Update displayed products based on search results
    displayProducts(filteredProducts);
});

// Handle buy button click to open buy modal
document.addEventListener('click', function (event) {
    if (event.target.classList.contains('buy-btn')) {
        const productId = event.target.getAttribute('data-id');
        const productName = event.target.getAttribute('data-name');
        const productPrice = event.target.getAttribute('data-price');
        document.getElementById('productId').value = productId;
        document.getElementById('productName').innerText = `Product: ${productName}`;
        document.getElementById('productPrice').innerText = `Price: $${productPrice}`;
    }
});

// Handle buy form submission
document.getElementById('buyForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Prevent default form submission
    const productId = parseInt(document.getElementById('productId').value);
    const quantity = parseInt(document.getElementById('quantityInput').value);
    const product = products.find(p => p.id === productId);
    if (!product) {
        alert('Product not found!');
        return;
    }
    if (quantity > product.quantity) {
        alert('Insufficient quantity!');
        return;
    }
    // Handle buying logic (e.g., update product quantity, add order to database, etc.)
    // For demonstration purposes, just display an alert
    alert(`Product '${product.name}' successfully bought with quantity ${quantity}.`);
    // Close the modal after buying
    $('#buyModal').modal('hide');
});

// Display products on page load
document.addEventListener('DOMContentLoaded', function () {
    displayProducts();
});