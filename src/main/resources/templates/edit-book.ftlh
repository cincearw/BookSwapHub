<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book - BookSwap Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body class="bg-dark text-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-lg-4">
    <div class="container">
        <a class="navbar-brand text-uppercase fw-bold" href="/">BookSwap Hub</a>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center text-warning mb-4">Edit Book Details</h2>

    <form method="post" action="/provider/editBook/${book.bookId}" class="bg-light p-4 rounded shadow-sm text-dark">
        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${book.title}" required>
        </div>

        <div class="mb-3">
            <label for="author" class="form-label">Author</label>
            <input type="text" class="form-control" id="author" name="author" value="${book.author}" required>
        </div>

        <div class="mb-3">
            <label for="genre" class="form-label">Genre</label>
            <input type="text" class="form-control" id="genre" name="genre" value="${book.genre}" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="4" required>${book.description}</textarea>
        </div>

        <button type="submit" class="btn btn-success w-100">Update Book</button>
        <a href="/provider/manage" class="btn btn-secondary mt-2 w-100">Cancel</a>
    </form>
</div>

<footer class="footer text-center py-4 bg-dark text-light mt-auto">
    <div class="container">
        <p class="m-0 small">&copy; BookSwap Hub 2025</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
