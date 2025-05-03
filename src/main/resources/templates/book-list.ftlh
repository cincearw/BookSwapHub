<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>BookSwap Hub - Available Books</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,500,700,900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/styles.css" />
</head>
<body>

<header>
    <h1 class="site-heading text-center text-faded d-none d-lg-block">
        <span class="site-heading-upper text-primary mb-3">BookSwap Hub</span>
        <span class="site-heading-lower">Discover. Swap. Read.</span>
    </h1>
</header>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark" id="mainNav">
    <div class="container">
        <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/">BookSwap Hub</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/customer/dashboard">Dashboard</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/library">Books</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/profile">Profile</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/reviews">Reviews</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="#" onclick="logout()">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Book Page Heading -->
<section class="page-section mt-5">
    <div class="container">
        <div class="text-center bg-warning text-dark p-4 rounded mb-3">
            <h2 class="section-heading mb-2">
                <span class="section-heading-upper fw-bold">Find Your Next Read</span>
                <span class="section-heading-lower">Available Books</span>
            </h2>
        </div>

        <div class="bg-light p-4 rounded mb-4 text-center">
            <p class="mb-0">Browse through a variety of books listed by fellow readers. Whether you love fiction, non-fiction, or niche genres, you can find and request books that match your interests.</p>
        </div>

        <!-- Genre Filter -->
        <form method="get" action="/library" class="mb-4">
            <div class="row g-2 align-items-center justify-content-center">
                <div class="col-auto">
                    <label for="genre" class="col-form-label fw-bold">Filter by Genre:</label>
                </div>
                <div class="col-auto">
                    <select name="genre" id="genre" class="form-select">
                        <option value="">All Genres</option>
                        <#list genres as g>
                        <option value="${g}" <#if genre?? && genre == g>selected</#if>>${g}</option>
                </#list>
                </select>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-warning">Filter</button>
            </div>
    </div>
    </form>
    </div>
</section>

<!-- Book Cards -->
<section class="page-section">
    <div class="container">
        <div class="row">
            <#list books as book>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="${book.imageUrl!'/assets/img/book-placeholder.jpg'}" class="card-img-top" alt="${book.title}">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${book.title}</h5>
                        <p class="card-text">by ${book.author}</p>
                        <p class="text-muted">Genre: ${book.genre}</p>
                        <p class="small">${book.description}</p>
                        <a href="/reviews" class="btn btn-success mt-auto w-100">Leave a Review</a>
                    </div>
                </div>
            </div>
        </#list>
    </div>
    </div>
</section>

<!-- Pagination Controls -->
<#if totalPages?? && totalPages &gt; 1>
<nav aria-label="Page navigation">
    <ul class="pagination justify-content-center mt-4">
        <#list 0..(totalPages - 1) as i>
        <li class="page-item <#if i == currentPage>active</#if>">
            <a class="page-link" href="?page=${i}<#if genre??>&genre=${genre}</#if>">${i + 1}</a>
        </li>
    </#list>
    </ul>
</nav>
</#if>


<!-- Footer -->
<footer class="footer text-faded text-center py-5 bg-dark text-light">
    <div class="container"><p class="m-0 small">Copyright &copy; BookSwap Hub 2025</p></div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
<script>
    function logout() {
      if (confirm("Are you sure you want to log out?")) {
        window.location.href = "/index.html";
      }
    }
</script>

</body>
</html>
