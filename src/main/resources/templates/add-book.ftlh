<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Book - BookSwap Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body>
<main class="container my-5">
    <h2 style="color: white;" class="text-center">Add New Book</h2>

    <form action="/provider/add-book" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="title" style="color: white;" class="form-label">Title:</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>
        <div class="mb-3">
            <label for="author" style="color: white;" class="form-label">Author:</label>
            <input type="text" class="form-control" id="author" name="author" required>
        </div>
        <div class="mb-3">
            <label for="genre" style="color: white;" class="form-label">Genre:</label>
            <input type="text" class="form-control" id="genre" name="genre" required>
        </div>
        <div class="mb-3">
            <label for="description" style="color: white;" class="form-label">Description:</label>
            <textarea class="form-control" id="description" name="description" required></textarea>
        </div>
        <div class="mb-3">
            <label for="image" style="color: white;" class="form-label">Book Cover Image:</label>
            <input type="file" class="form-control" id="image" name="image" required>
        </div>
        <button type="submit" class="btn btn-success">Add Book</button>
    </form>
</main>
</body>
</html>