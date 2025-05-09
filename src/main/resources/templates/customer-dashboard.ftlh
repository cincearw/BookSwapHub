<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Customer Dashboard - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,700,900" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/static/css/styles.css" />
</head>
<body>
<body style="background-image: url('/static/assets/img/book_background.jpg'); background-size: cover; background-repeat: no-repeat; background-position: center;" >
<header class="bg-dark text-light py-5 text-center">
    <h1 class="fw-bold text-uppercase">BookSwap Hub</h1>
    <h2 class="text-warning">Customer Dashboard</h2>
</header>

<nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark">
    <div class="container">
        <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/">BookSwap Hub</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/customer/dashboard">Dashboard</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/library">Books</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/swaps">Swaps</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/profile">Profile</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/reviews">Reviews</a></li>
                <li class="nav-item px-lg-4">
                    <a class="nav-link text-uppercase" href="#" onclick="logout()">Logout</a>
            </ul>
        </div>
    </div>
</nav>

<section class="container my-5">
    <div class="bg-warning p-5 rounded shadow-sm text-center text-dark">
        <h2 class="mb-3">Welcome Back, ${user.name!"Guest"}</h2>
        <p class="lead">Manage your book swaps, track your requests, and update your profile.</p>
    </div>
</section>

<section class="container my-5">
    <div class="row g-4">
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold">Pending Swap Requests</h5>
                    <p class="card-text">You have <strong>${pendingSwaps!0}</strong> pending swap requests.</p>
                    <a href="/swaps" class="btn btn-warning mt-auto">View Requests</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold">Accepted Swaps</h5>
                    <p class="card-text">You have <strong>${acceptedSwaps!0}</strong> accepted swap(s).</p>
                    <a href="/swaps" class="btn btn-success mt-auto">View Details</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold">Book Recommendations</h5>
                    <p class="card-text">Based on your interests, check out these recommended books!</p>
                    <a href="/library" class="btn btn-info mt-auto">View Recommendations</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold">Messages</h5>
                    <p class="card-text">You have <strong>${messages!0}</strong> new messages.</p>
                    <a href="/messages" class="btn btn-primary mt-auto">Go to Messages</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold">Share Your Thoughts</h5>
                    <p class="card-text">Leave a review on books you've read.</p>
                    <a href="/reviews" class="btn btn-dark mt-auto">Go to Reviews</a>
                </div>
            </div>
        </div>
    </div>
</section>


<footer class="footer text-center py-5 bg-dark text-light mt-5 border-top border-light">
    <div class="container">
        <p class="m-0 small">&copy; BookSwap Hub 2025</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
