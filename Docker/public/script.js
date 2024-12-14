document.addEventListener('DOMContentLoaded', function() {
    // Sample products
    const products = [
        { id: 1, name: 'Product 1', price: '$100' },
        { id: 2, name: 'Product 2', price: '$150' },
        { id: 3, name: 'Product 3', price: '$200' },
    ];

    // Get the products container from the DOM
    const productsContainer = document.querySelector('.products');

    // Loop through the products and create HTML for each one
    products.forEach(product => {
        const productElement = document.createElement('div');
        productElement.classList.add('product');
        
        productElement.innerHTML = `
            <h3>${product.name}</h3>
            <p>Price: ${product.price}</p>
            <button class="add-to-cart">Add to Cart</button>
        `;
        
        // Append the product to the products container
        productsContainer.appendChild(productElement);
    });

    // Optional: Add event listener for "Add to Cart" buttons
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function() {
            alert('Added to cart');
        });
    });
});

