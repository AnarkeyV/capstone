/**
 * The Shirt Bar — cart.js
 * Handles: mobile nav, cart interactions, flash message dismissal
 */

document.addEventListener('DOMContentLoaded', function () {

  // ============================================================
  // MOBILE NAV TOGGLE
  // ============================================================
  const navToggle = document.getElementById('navToggle');
  const navLinks  = document.getElementById('navLinks');

  if (navToggle && navLinks) {
    navToggle.addEventListener('click', function () {
      const isOpen = navLinks.classList.toggle('open');
      navToggle.setAttribute('aria-expanded', isOpen);
    });

    // Close nav when a link is clicked
    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => navLinks.classList.remove('open'));
    });

    // Close nav on outside click
    document.addEventListener('click', function (e) {
      if (!navToggle.contains(e.target) && !navLinks.contains(e.target)) {
        navLinks.classList.remove('open');
      }
    });
  }

  // ============================================================
  // FLASH MESSAGE AUTO-DISMISS
  // ============================================================
  const flashMessages = document.querySelectorAll('.flash');
  flashMessages.forEach(function (msg) {
    setTimeout(function () {
      msg.style.transition = 'opacity 0.4s ease';
      msg.style.opacity = '0';
      setTimeout(() => msg.remove(), 400);
    }, 4000); // dismiss after 4 seconds
  });

  // ============================================================
  // CART QUANTITY SYNC
  // Keeps the cart badge count in the nav updated when
  // quantity forms are submitted (for future AJAX use)
  // ============================================================
  function updateCartBadge(count) {
    const badge = document.querySelector('.cart-badge');
    const cartCount = document.querySelector('.cart-count');

    if (count > 0) {
      if (badge) {
        badge.textContent = count;
        badge.style.display = 'flex';
      }
      if (cartCount) cartCount.textContent = '(' + count + ')';
    } else {
      if (badge) badge.style.display = 'none';
      if (cartCount) cartCount.textContent = '';
    }
  }

  // ============================================================
  // PRODUCT PAGE: Thumbnail gallery switcher
  // ============================================================
  const thumbnails = document.querySelectorAll('.thumbnail');
  const mainImage  = document.getElementById('mainImage');

  if (thumbnails.length && mainImage) {
    thumbnails.forEach(function (thumb) {
      thumb.addEventListener('click', function () {
        thumbnails.forEach(t => t.classList.remove('active'));
        thumb.classList.add('active');

        const src = thumb.dataset.src;
        if (src && src !== '#' && mainImage.tagName === 'IMG') {
          mainImage.src = src;
        }
      });
    });
  }

  // ============================================================
  // CART PAGE: Live subtotal update (visual only — server
  // recalculates on form submit for accuracy)
  // ============================================================
  const cartRows = document.querySelectorAll('.cart-row');

  cartRows.forEach(function (row) {
    const qtyInput = row.querySelector('input[name="quantity"]');
    const subtotalCell = row.querySelector('.cart-subtotal');

    if (qtyInput && subtotalCell) {
      // Store the unit price as a data attribute if available
      const unitPriceEl = row.querySelector('.cart-unit-price');
      if (unitPriceEl) {
        const priceText = unitPriceEl.textContent.replace(/[^0-9.]/g, '');
        const unitPrice = parseFloat(priceText);

        qtyInput.addEventListener('input', function () {
          const qty = parseInt(qtyInput.value) || 1;
          const subtotal = (unitPrice * qty).toFixed(2);
          subtotalCell.textContent = 'S$' + subtotal;
        });
      }
    }
  });

  // ============================================================
  // ADD TO CART: Button loading state feedback
  // ============================================================
  const addToCartForm = document.querySelector('.add-to-cart-form');
  const addToCartBtn  = document.getElementById('addToCartBtn');

  if (addToCartForm && addToCartBtn) {
    addToCartForm.addEventListener('submit', function (e) {
      // Check size selected
      const sizeInput = document.getElementById('sizeInput');
      if (sizeInput && !sizeInput.value) {
        e.preventDefault();
        // Highlight size selector
        const sizeGroup = document.querySelector('.size-buttons');
        if (sizeGroup) {
          sizeGroup.style.outline = '2px solid #dc2626';
          sizeGroup.style.outlineOffset = '4px';
          setTimeout(() => {
            sizeGroup.style.outline = '';
            sizeGroup.style.outlineOffset = '';
          }, 2000);
        }
        return;
      }

      // Show loading state
      addToCartBtn.disabled = true;
      addToCartBtn.textContent = 'Adding…';
    });
  }

  // ============================================================
  // SMOOTH SCROLL for anchor links
  // ============================================================
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  // ============================================================
  // CHECKOUT: Prevent double-submit
  // ============================================================
  const checkoutForm = document.getElementById('payment-form');
  if (checkoutForm) {
    let submitted = false;
    checkoutForm.addEventListener('submit', function () {
      // Only prevent double-submit for non-Stripe forms
      // (Stripe handler manages its own submit prevention)
      if (!window.Stripe && !submitted) {
        submitted = true;
        const btn = document.getElementById('submit-btn');
        if (btn) {
          btn.disabled = true;
          btn.textContent = 'Processing…';
        }
      }
    });
  }

});
