<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Provider Dashboard - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,200,300,400,500,600,700,800,900" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        body > main {
            flex: 1;
        }
    </style>
</head>
<body>

<main>
    <header class="bg-dark text-light py-5 text-center">
        <h1 class="fw-bold text-uppercase">BookSwap Hub</h1>
        <h2 class="text-warning">Provider Dashboard</h2>
    </header>

    <nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark">
        <div class="container">
            <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/">BookSwap Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/provider/home">Home</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider">Manage Books</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/requests">Swap Requests</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/listings">Listings</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/stats">Profile</a></li>
                    <a class="nav-link text-uppercase" href="/logout">Logout</a>
                </ul>
            </div>
        </div>
    </nav>

    <section class="container my-5">
        <div class="row text-center">
            <#list [
            {"title": "Manage Books", "desc": "View and edit your book collection.", "link": "/provider"},
            {"title": "Swap Requests", "desc": "Check pending swap requests.", "link": "/requests"},
            {"title": "Listings", "desc": "Manage your listed books.", "link": "/listings"},
            {"title": "Profile", "desc": "Update your provider details.", "link": "/stats"}
            ] as card>
            <div class="col-md-6 col-lg-3 mb-4">
                <div class="card bg-warning text-dark shadow-sm h-100">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <h5 class="card-title fw-bold">${card.title}</h5>
                        <p class="card-text">${card.desc}</p>
                        <a href="${card.link}" class="btn btn-dark mt-auto">Go</a>
                    </div>
                </div>
            </div>
        </#list>
        </div>
    </section>

    <section class="container mt-4">
        <div class="bg-light p-4 rounded shadow-sm">
            <h4 class="text-dark mb-3">📢 New Notifications</h4>
            <ul class="list-group list-group-flush">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    You have <strong>${newRequests!0}</strong> new swap requests.
                    <a href="/requests" class="btn btn-sm btn-outline-warning">View</a>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Your listing "<strong>The Great Gatsby</strong>" was requested.
                    <a href="/listings" class="btn btn-sm btn-outline-warning">Manage</a>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Profile update reminder: Keep your profile updated.
                    <a href="/stats" class="btn btn-sm btn-outline-warning">Edit</a>
                </li>
            </ul>
        </div>
    </section>
</main>

<footer class="footer text-center py-4 bg-dark text-light border-top border-light mt-auto">
    <div class="container">
        <p class="m-0 small">Copyright &copy; BookSwap Hub 2025</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
<script>
    function logout() {
        if (confirm("Are you sure you want to log out?")) {
            window.location.href = "/";
        }
    }
</script>
</body>
</html>
