<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Listings - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,200,300,400,500,600,700,800,900" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body>
<main>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark">
        <div class="container">
            <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/">BookSwap Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider">Manage Books</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/requests">Swap Requests</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/listings">Listings</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/stats">Profile</a></li>
                    <a class="nav-link text-uppercase" href="/logout">Logout</a>
                </ul>
            </div>
        </div>
    </nav>

    <section class="container my-5">
        <h2 class="text-center">Your Book Listings</h2>

        <div class="row">
            <#list listings as listing>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="${listing.coverUrl}" class="card-img-top" alt="${listing.title}">
                    <div class="card-body">
                        <h5 class="card-title">${listing.title}</h5>
                        <p class="card-text">${listing.author}</p>
                        <a href="/listings/${listing.id}" class="btn btn-primary">Manage</a>
                    </div>
                </div>
            </div>
        </#list>
        </div>
    </section>
</main>

<footer class="footer text-center py-4 bg-dark text-light border-top border-light mt-auto">
    <div class="container">
        <p class="m-0 small">Copyright &copy; BookSwap Hub 2025</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>