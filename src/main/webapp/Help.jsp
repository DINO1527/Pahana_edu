<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>System Help - Staff</title>
  <!-- Bootstrap 5 (no jQuery required) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/css/fontawesome.css">
  <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
  <link rel="stylesheet" href="assets/css/owl.css">
  <link rel="stylesheet" href="assets/css/animate.css">
  <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    body { padding-top: 2.5rem; }
    .toc a { text-decoration: none; }
    .help-floating {
      position: fixed; right: 20px; bottom: 24px; z-index: 9999;
      width: 56px; height: 56px; border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      box-shadow: 0 6px 18px rgba(0,0,0,0.15);
      background: #fc7e38; color: #fff; font-weight: 700; cursor: pointer;
    }
    pre.example {
        background:#f8f9fa;
        padding:12px;
        border-radius:6px;
    }

  </style>
</head>
<body>
<header class="header-area header-sticky" style="background-color: rgba(252,126,56,0.63);top: 0;position: fixed">
  <div class="container" >
    <div class="row">
      <div class="col-12">
        <nav class="main-nav">
          <!-- ***** Logo Start ***** -->
          <a href="index.html" class="logo">
            <img src="assets/images/logo.png" alt="" style="width: 80px;">
          </a>
          <a class="navbar-brand" href="#">pahana edu - Staff Help</a>
          <!-- ***** Logo End ***** -->
          <!-- ***** Menu Start ***** -->
          <ul class="nav">
            <li><a href="javascript:history.back()">❌</a></li>
          </ul>
          <a class='menu-trigger'>
            <span>Menu</span>
          </a>
          <!-- ***** Menu End ***** -->
        </nav>
      </div>
    </div>
  </div>
</header>




<main class="container">
  <div class="row" style="margin-top: 100px; top: 100px">
    <div class="col-lg-4">
      <div class="card mb-3">
        <div class="card-body">
          <h5 class="card-title">Help Contents</h5>
          <ul class="list-unstyled toc">
            <li><a href="#dashboard" class="d-block py-1">Dashboard (Navigation)</a></li>
            <li><a href="#billing" class="d-block py-1">Billing Page</a></li>
            <li><a href="#customer" class="d-block py-1">Customer Management</a></li>
            <li><a href="#inventory" class="d-block py-1">Inventory Management</a></li>
            <li><a href="#userdetails" class="d-block py-1">User Details / Reset Password</a></li>
            <li><a href="#exit" class="d-block py-1">Exit System</a></li>
          </ul>


        </div>
      </div>
    </div>

    <div class="col-lg-8">
      <!-- Dashboard -->
      <section id="dashboard" class="mb-4">
        <h3>Dashboard (Navigation)</h3>
        <p>The dashboard is the starting point for staff. It contains navigation tiles for:</p>
        <ul>
          <li><strong>Billing</strong> — Create and save customer bills.</li>
          <li><strong>Customer Management</strong> — View, search and edit customer records.</li>
          <li><strong>Inventory Management</strong> — View and update stock.</li>
          <li><strong>User Details</strong> — View your account and reset password.</li>
        </ul>
        <p><strong>How to use:</strong> Click the tile or navigation link for the feature you want. If you need help for the current page, click the floating <span class="badge bg-primary">?</span> button or visit <code>help.jsp#sectionId</code>.</p>
      </section>

      <!-- Billing -->
      <section id="billing" class="mb-4">
        <h3>Billing Page</h3>
        <p>Workflow summary — steps your staff should follow to create and save a bill.</p>
        <ol>
          <li><strong>Lookup customer:</strong> Enter customer <em>account number</em> or <em>phone number</em> and press <em>Search</em>.
            <ul>
              <li>If a match is found, the system loads the customer details and recent billing activity.</li>
              <li>If not found, an error message appears and you can click <strong>Add New Customer</strong> to create a customer on the spot.</li>
            </ul>
          </li>
          <li><strong>Add items to the bill:</strong>
            <ul>
              <li>Enter the <em>book ID</em> (or use the lookup button), the system fills item name, price and available stock.</li>
              <li>Enter <em>quantity</em>. The line <em>sub‑total</em> is calculated as <code>price × quantity</code>. The page automatically updates the <em>grand total</em>.</li>
              <li>To add another item, click <strong>Add Row</strong>. Each row has its own item, quantity and sub‑total.</li>
            </ul>
          </li>
          <li><strong>Stock validation:</strong>
            <ul>
              <li>If entered quantity &gt; available stock, the system shows an error message and prevents saving the bill for that row until corrected.</li>
              <li>Example message: <em>"Quantity requested exceeds available stock (Available: 3)."</em></li>
            </ul>
          </li>
          <li><strong>Payment and save:</strong>
            <ul>
              <li>Select payment method (Cash / Card / Other) and press <strong>Save Bill</strong>.</li>
              <li>System will validate: customer present, at least one valid line, stock checks passed, and a payment method selected.</li>
            </ul>
          </li>
          <li><strong>After saving:</strong>
            <ul>
              <li>Bill is stored in <code>order_history</code> with <code>order_items</code> rows.</li>
              <li>Inventory is decremented according to sold quantities.</li>
              <li>A printable receipt view is offered (open print dialog / download PDF).</li>
            </ul>
          </li>
        </ol>

        <h6>Quick tips and common errors</h6>
        <ul>
          <li>If the customer lookup accepts phone OR account number, make sure your staff uses the same format used in the database (no leading spaces, country code rules).</li>
          <li>Ensure the item lookup returns available stock; if stock isn't updating after saving, verify the inventory update SQL runs after inserting order items.</li>
        </ul>
      </section>

      <!-- Customer Management -->
      <section id="customer" class="mb-4">
        <h3>Customer Management System</h3>
        <p>The main customer page shows all customers in a searchable table.</p>
        <p><strong>Search</strong> — Use the search bar to find customers by <em>name</em>, <em>account number</em> or <em>phone number</em>. The search should be case-insensitive and trim whitespace.</p>
        <p><strong>View details</strong> — Click a row to open the customer's details page. That page shows:
          <ul>
            <li>Customer personal details (name, address, phone, account number)</li>
            <li>All shopping/billing history linked to the customer</li>
            <li>Buttons: <strong>Edit</strong>, <strong>Print Statement</strong>, <strong>Close</strong>
          </ul>
        </p>
        <p><strong>Edit workflow:</strong></p>
        <ol>
          <li>Click <strong>Edit</strong> — fields become editable and an <strong>Update</strong> button appears.</li>
          <li>All fields must be validated before update: e.g. phone numeric + length, account number unique (if changed), required fields non-empty.</li>
          <li>On success, show a confirmation and return to the customer's detail view or back to the customers list if staff clicks <strong>Close</strong>.</li>
        </ol>

        <h6>Recommended validations</h6>
        <ul>
          <li>Account number: required, pattern check (your system rules), uniqueness check on update.</li>
          <li>Phone: required, digits only, length limits.</li>
          <li>Address: optional but recommended; avoid accepting <em>script</em> tags — sanitize input.</li>
        </ul>
      </section>

      <!-- Inventory Management -->
      <section id="inventory" class="mb-4">
        <h3>Inventory Management</h3>
        <p>The inventory page behaves similarly to customer management: searchable table with stock, sold and available columns.</p>
        <p><strong>Columns to display:</strong> Item ID, Title, Category, Purchase Price, Selling Price, Opening Stock, Sold, Available Stock.</p>
        <p><strong>Item actions:</strong>
          <ul>
            <li><strong>View / Edit</strong> — update item details and stock levels.</li>
            <li><strong>Add New Book</strong> — show a form to add a new inventory item including image upload, pricing and initial stock.</li>
          </ul>
        </p>
        <p><strong>Stock rules:</strong> When saving a sale (bill), ensure available stock decreases; when adding stock (purchase/return) increase it. Keep a log table for stock transactions if possible.</p>
      </section>

      <!-- User details -->
      <section id="userdetails" class="mb-4">
        <h3>User Details (Your Staff Account)</h3>
        <p>Click your username (top-right in navigation) to open the user details page. Features:</p>
        <ul>
          <li>Profile information (name, email)</li>
          <li>Reset password — requires current password and new password (confirm). Validate password strength and match.</li>
          <li>Profile image upload (optional)</li>
        </ul>
        <p>After password reset, you may optionally force a re-login for security.</p>
      </section>

      <!-- Exit System -->
      <section id="exit" class="mb-4">
        <h3>Exit System</h3>
        <p>To exit the staff application safely:</p>
        <ol>
          <li>Use the <strong>Logout</strong> button in the navigation. This should invalidate the session server-side (<code>session.invalidate()</code> in servlet/JSP).</li>
          <li>Ensure pages containing sensitive data include headers to prevent caching:
            <pre class="example">response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);
</pre>
          </li>
          <li>After logout, redirect to <code>login.jsp</code> and ensure protected pages redirect back to login if no session is present.</li>
        </ol>
      </section>

      <!-- Troubleshooting -->
      <section id="troubleshoot" class="mb-4">
        <h3>Troubleshooting</h3>
        <h6>Common issues</h6>
        <ul>
          <li><strong>Login cached:</strong> Client may show previous credentials — fix with the cache headers above and ensure you clear fields on logout.</li>
          <li><strong>Stock not updated:</strong> Confirm that inventory decrement SQL runs after order_items insert and that transactions commit properly.</li>
          <li><strong>Duplicate account numbers:</strong> Validate uniqueness on add/update and show user-friendly message on conflict.</li>
        </ul>
      </section>

      <!-- Footer: quick links -->
      <div class="card mt-3">
        <div class="card-body small">
          <strong>Quick links:</strong>
          <ul class="mb-0">
            <li><a href="help.jsp#billing">Billing help</a></li>
            <li><a href="help.jsp#customer">Customer management</a></li>
            <li><a href="help.jsp#inventory">Inventory management</a></li>
          </ul>
        </div>
      </div>

    </div>
  </div>
</main>

<!-- Floating help button (context-sensitive) -->
<div class="help-floating" id="helpFloat" title="Open help">?</div>
<jsp:include page="footer.jsp" />
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Open section based on hash or ?help= query param
  (function() {
    function openFromHashOrParam(){
      const params = new URLSearchParams(location.search);
      const q = params.get('help');
      const hash = location.hash.replace('#','');
      const idToOpen = q || hash || '';
      if(idToOpen){
        const el = document.getElementById(idToOpen);
        if(el){ el.scrollIntoView({behavior:'smooth', block:'start'});
        // highlight briefly
        el.style.transition = 'background-color 0.6s';
        el.style.backgroundColor = '#fff3cd';
        setTimeout(()=> el.style.backgroundColor = '', 1600);
        }
      }
    }
    // run on load
    window.addEventListener('load', openFromHashOrParam);

    // floating help button opens contents
    document.getElementById('helpFloat').addEventListener('click', function(){
      window.location.href = 'help.jsp';
    });
  })();
</script>
</body>
</html>
