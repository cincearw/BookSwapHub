<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Swaps - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
</head>

<body class="bg-dark text-light min-vh-100 d-flex flex-column">

<!-- Hero Section -->
<header>
    <h1 class="site-heading text-center text-faded d-none d-lg-block">
        <span class="site-heading-upper text-primary mb-3">BookSwap Hub</span>
        <span class="site-heading-lower">Discover. Swap. Read.</span>
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
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/customer/dashboard">Dashboard</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/library">Books</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/swaps">Swaps</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/profile">Profile</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/reviews">Reviews</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="flex-grow-1 container mt-5">
    <h2 class="text-center text-warning">Your Book Swaps</h2>

    <!-- Pending Swaps -->
    <div class="bg-light text-dark p-4 rounded shadow-sm mt-4">
        <h4>Pending Swaps</h4>
        <p class="text-muted">These swaps are awaiting confirmation.</p>
        <#if pendingSwaps?? && (pendingSwaps?size > 0)>
        <ul class="list-group">
            <#list pendingSwaps as swap>
            <li class="list-group-item">
                "${swap.book.title}" - Requested on ${swap.requestedAt}
            </li>
        </#list>
        </ul>
        <#else>
        <div class="form-control">No pending swaps.</div>
    </#if>
</div>

<!-- Accepted Swaps -->
<div class="bg-light text-dark p-4 rounded shadow-sm mt-4">
    <h4>Accepted Swaps</h4>
    <p class="text-muted">These swaps have been successfully matched.</p>
    <#if acceptedSwaps?? && (acceptedSwaps?size > 0)>
    <ul class="list-group">
        <#list acceptedSwaps as swap>
        <li class="list-group-item">
            "${swap.book.title}" - Accepted on ${swap.updatedAt}
        </li>
    </#list>
    </ul>
    <#else>
    <div class="form-control">No accepted swaps.</div>
</#if>
</div>
</div>

<!-- Footer -->
<footer class="footer text-center py-4 bg-dark text-light mt-auto">
    <div class="container">
        <p class="m-0 small">&copy; BookSwap Hub 2025</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
