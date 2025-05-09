<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Swap Requests - BookSwap Hub</title>
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
                    <a class="nav-link text-uppercase" href="/logout">Logout</a>
                </ul>
            </div>
        </div>
    </nav>

    <section class="container my-5">
        <h2 class="text-center">Your Swap Requests</h2>

        <div class="list-group">
            <#list swapRequests as request>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">${request.book.title}</h5>
                    <p class="card-text">${request.requester.name} is requesting your book!</p>
                    <p class="card-text"><small class="text-muted">${request.requestedAt!''}</small></p>

                    <!-- Show the status of the request -->
                    <p class="card-text">
                        <strong>Status:</strong>
                        <#if request.status??>
                        <#if request.status == "ACCEPTED">
                        <span class="text-success">${request.status}</span>
                        <#elseif request.status == "DENIED">
                        <span class="text-danger">${request.status}</span>
                        <#else>
                        <span class="text-secondary">${request.status}</span>
                    </#if>
                    <#else>
                    <span class="text-muted">Pending</span>
                </#if>
                </p>

                <!-- Approve and Deny buttons will be hidden if a decision is made -->
                <#if request.status != "ACCEPTED" && request.status != "DENIED">
                <form method="post" action="/requests/${request.swapId}/approve" class="d-inline">
                    <button type="submit" class="btn btn-success btn-sm">Accept</button>
                </form>

                <form method="post" action="/requests/${request.swapId}/deny" class="d-inline ms-2">
                    <button type="submit" class="btn btn-danger btn-sm">Deny</button>
                </form>
            </#if>
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