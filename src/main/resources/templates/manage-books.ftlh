<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Books - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,200,300,400,500,600,700,800,900" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body>
<main>
    <nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark">
        <div class="container">
            <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/">BookSwap Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/provider/home">Home</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/manage">Manage Books</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/requests">Swap Requests</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/listings">Listings</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/${provider.userId}">Profile</a></li>
                    <a class="nav-link text-uppercase" href="/logout">Logout</a>
                </ul>
            </div>
        </div>
    </nav>

    <section class="container my-5">
        <h2 class="text-center">Manage Your Books</h2>
        <p class="text-center">Here you can add, edit, or remove your books from the library.</p>

        <div class="row text-center">
            <#list books as book>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="${book.imageUrl}" class="card-img-top" alt="${book.title}">
                    <div class="card-body">
                        <h5 class="card-title">${book.title}</h5>
                        <p class="card-text">${book.author}</p>
                        <a href="/provider/editBook/${book.bookId}" class="btn btn-primary">Edit</a>
                        <form action="/provider/deleteBook/${book.bookId}" method="post" style="display:inline;">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </#list>
        </div>
        <a href="/provider/add-book" class="btn btn-success">Add New Book</a>
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