<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>BookSwap Hub - Reviews</title>
  <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i" rel="stylesheet" />
  <!-- Bootstrap CSS (CDN recommended) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Core theme CSS (includes Bootstrap) -->
  <link rel="stylesheet" href="/css/styles.css" />
</head>
<body>
<header>
  <h1 class="site-heading text-center text-faded d-none d-lg-block">
    <span class="site-heading-upper text-primary mb-3">BookSwap Hub</span>
    <span class="site-heading-lower">User Reviews</span>
  </h1>
</header>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark" id="mainNav">
  <div class="container">
    <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="index.html">BookSwap Hub</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mx-auto">
        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/customer/dashboard">Dashboard</a></li>
        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/library">Books</a></li>
        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="profile.html">Profile</a></li>
        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/reviews">Reviews</a></li>
        <li class="nav-item px-lg-4">
          <a class="nav-link text-uppercase" href="#" onclick="logout()">Logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Review Section -->
<section class="page-section">
  <div class="container">
    <div class="bg-faded p-5 rounded">
      <h2 class="section-heading mb-4">
        <span class="section-heading-upper">Share Your Experience</span>
        <span class="section-heading-lower">Reviews</span>
      </h2>
      <p class="text-center">Browse reviews from fellow readers or leave your own to help others find their next great read!</p>
    </div>
  </div>
</section>

<!-- User Submitted Reviews -->
<section class="page-section">
  <div class="container">
    <h2 class="text-center">Your Submitted Reviews</h2>
    <div class="row" id="submittedReviews">
      <#list reviews as review>
      <div class="col-md-6 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">${review.book.title}</h5>
            <p class="card-text"><strong>Rating:</strong> <#list 1..review.rating as i>⭐</#list></p>
            <p>${review.comment}</p>
          </div>
        </div>
      </div>
    </#list>
  </div>
  </div>
</section>



<!-- Leave a Review -->
<section class="page-section">
  <div class="container">
    <h2 class="text-center">Leave a Review</h2>
    <form action="/reviews" method="post">
      <div class="mb-3">
        <input type="text" class="form-control" name="username" value="${loggedInUsername}" readonly>
      </div>

      <div class="mb-3">
        <label for="bookTitle" class="form-label">Book Title:</label>
        <select name="bookTitle" id="bookTitle" class="form-select" required>
          <#list books as book>
          <option value="${book.title}">${book.title}</option>
        </#list>
        </select>
      </div>

      <div class="mb-3">
        <label>Rating:</label>
        <select name="rating" class="form-select" required>
          <option value="5">⭐⭐⭐⭐⭐</option>
          <option value="4">⭐⭐⭐⭐</option>
          <option value="3">⭐⭐⭐</option>
          <option value="2">⭐⭐</option>
          <option value="1">⭐</option>
        </select>
      </div>
      <div class="mb-3">
        <label>Comment:</label>
        <textarea name="comment" class="form-control" rows="3" required></textarea>
      </div>
      <button class="btn btn-primary w-100" type="submit">Submit Review</button>
    </form>
  </div>
</section>


<!-- Footer -->
<footer class="footer text-faded text-center py-5 bg-dark text-light">
  <div class="container"><p class="m-0 small">Copyright &copy; BookSwap Hub 2025</p></div>
</footer>

  <!-- Bootstrap Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Your custom JS -->
  <script src="/js/scripts.js"></script>

<!-- Logout Script -->
  <script>
    function logout() {
      console.log("Logout button clicked");

      let confirmLogout = confirm("Are you sure you want to log out?");
      if (confirmLogout) {
        console.log("User confirmed logout");
        window.location.href = "../index.html";
      } else {
        console.log("User canceled logout");
      }
    }
  </script>
</body>
</html>

