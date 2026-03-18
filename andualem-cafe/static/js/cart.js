/* ============================================================
   Andualem Café — Cart (localStorage-based)
   ============================================================ */

var CART_KEY = 'andualem_cart';

function getCart() {
    try {
        return JSON.parse(localStorage.getItem(CART_KEY)) || [];
    } catch (e) {
        return [];
    }
}

function saveCart(cart) {
    localStorage.setItem(CART_KEY, JSON.stringify(cart));
}

function cartAddItem(id, name, price) {
    var cart = getCart();
    var existing = cart.find(function(i) { return i.id === id; });
    if (existing) {
        existing.quantity += 1;
    } else {
        cart.push({ id: id, name: name, price: parseFloat(price), quantity: 1 });
    }
    saveCart(cart);
    updateCartBadge();
}

function getCartCount() {
    return getCart().reduce(function(sum, i) { return sum + i.quantity; }, 0);
}

function getCartTotal() {
    return getCart().reduce(function(sum, i) { return sum + i.price * i.quantity; }, 0);
}

function updateCartBadge() {
    var count = getCartCount();
    var badge = document.getElementById('cart-badge');
    var mobileCount = document.getElementById('mobile-cart-count');
    if (badge) {
        if (count > 0) {
            badge.textContent = count;
            badge.style.display = 'flex';
        } else {
            badge.style.display = 'none';
        }
    }
    if (mobileCount) {
        mobileCount.textContent = count;
    }
}

// Mobile nav toggle
document.addEventListener('DOMContentLoaded', function () {
    updateCartBadge();

    var toggle = document.getElementById('nav-toggle');
    var mobileNav = document.getElementById('mobile-nav');
    if (toggle && mobileNav) {
        toggle.addEventListener('click', function () {
            mobileNav.classList.toggle('open');
        });
    }
});
