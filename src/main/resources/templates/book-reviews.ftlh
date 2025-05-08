<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${book.title} - Reviews</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<header class="text-center py-4 bg-dark text-light">
    <h2>Reviews for <em>${book.title}</em> by ${book.author}</h2>
</header>

<div class="container mt-4">
    <#if reviews?size == 0>
    <p style="color: black;" class="text-center">No reviews yet for this book.</p>
    <#else>
    <div class="row">
        <#list reviews as review>
        <div class="col-md-6 mb-3">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Rating: <#list 1..review.rating as i>⭐</#list></h5>
                    <p class="card-text">${review.comment}</p>
                    <p class="text-muted small">Reviewed by ${review.reviewer.username} on ${review.createdAt}</p>
                </div>
            </div>
        </div>
    </#list>
</div>
</#if>
<div class="text-center mt-4">
    <a href="/library" class="btn btn-secondary">Back to Library</a>
</div>
</div>

</body>
</html>
