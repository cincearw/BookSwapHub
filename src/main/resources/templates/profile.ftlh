<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BookSwap Hub - Profile</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body>
<header>
    <h1 class="site-heading text-center text-faded d-none d-lg-block">
        <span class="site-heading-upper text-primary mb-3">BookSwap Hub</span>
        <span class="site-heading-lower">Your Profile</span>
    </h1>
</header>

<!-- Navigation -->
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

<!-- Profile Section -->
<section class="page-section">
    <div class="container">
        <div class="bg-faded p-5 rounded">
            <h2 class="section-heading mb-4">
                <span class="section-heading-upper">User Information</span>
                <span class="section-heading-lower">Profile Details</span>
            </h2>
            <div class="row">
                <div class="col-md-4 text-center">
                    <img src="/assets/img/profile-avatar.jpg" class="rounded-circle img-fluid" alt="User Avatar" width="150">
                </div>
                <div class="col-md-8">
                    <p><strong>Username:</strong> ${user.username}</p>
                    <p><strong>Location:</strong> ${user.bio!''}</p>
                    <p><strong>Member Since:</strong> ${memberSince}</p>
                    <p><strong>Favorite Genres:</strong> ${user.favoriteGenres!"N/A"}</p>
                    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editProfileModal">Edit Profile</button>
                </div>
            </div>
        </div>
    </div>
</section>

<#if successMessage??>
<div class="alert alert-success mt-3 text-center">${successMessage}</div>
</#if>

<!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="/profile/update">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label>Name:</label>
                    <input type="text" name="name" class="form-control mb-2" value="${user.name}">
                    <label>Location:</label>
                    <input type="text" name="bio" class="form-control mb-2" value="${user.bio!}">
                    <label>Favorite Genres:</label>
                    <input type="text" name="favoriteGenres" class="form-control" value="${user.favoriteGenres!}">
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer text-faded text-center py-5 bg-dark text-light">
    <div class="container"><p class="m-0 small">© BookSwap Hub 2025</p></div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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
