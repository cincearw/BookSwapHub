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
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/${provider.userId}">Profile</a></li>
                    <li class="nav-item px-lg-4">
                        <a class="nav-link text-uppercase" href="#" onclick="logout()">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="page-section">
        <div class="container">
            <h2 class="text-center text-white mb-4">Manage Your Books</h2>
            <p class="text-center text-white mb-5">Here you can add, edit, or remove your books from the library.</p>

            <div class="row">
                <#list books as book>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <img src="${book.imageUrl!'/assets/img/book-placeholder.jpg'}?v=${.now?long}" class="card-img-top" alt="${book.title}">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">${book.title}</h5>
                            <p class="card-text">${book.author}</p>
                            <div class="mt-auto">
                                <a href="/provider/editBook/${book.bookId}" class="btn btn-outline-primary w-100 mb-2">Edit</a>
                                <form action="/provider/deleteBook/${book.bookId}" method="post" onsubmit="return confirm('Are you sure you want to delete this book?');">
                                    <button type="submit" class="btn btn-danger w-100">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </#list>
        </div>

        <div class="text-center mt-4">
            <a href="/provider/add-book" class="btn btn-success">Add New Book</a>
        </div>
        </div>
    </section>
</main>

<footer class="footer text-center py-4 bg-dark text-light border-top border-light mt-auto">
    <div class="container">
        <p class="m-0 small">&copy; BookSwap Hub 2025</p>
    </div>
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