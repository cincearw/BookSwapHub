<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Provider Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,500,700,900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Raleway', sans-serif;
            background-color: #f8f9fa;
        }
        h2, h3 {
            font-family: 'Lora', serif;
            color: #343a40;
        }
        .section {
            margin-top: 2.5em;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-lg-4">
    <div class="container">
        <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/">BookSwap Hub</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/dashboard">Dashboard</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/library">Books</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/profile">Profile</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/reviews">Reviews</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="#" onclick="logout()">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Welcome Section -->
<div class="container section">
    <div class="bg-white p-4 rounded shadow-sm">
        <h2>Welcome, ${provider.name}</h2>
        <p><strong>Username:</strong> ${provider.username}</p>
        <p><strong>Email:</strong> ${provider.email}</p>
        <p><strong>Bio:</strong> ${provider.bio}</p>
        <p><strong>Rating:</strong>
            <#if provider.rating??>
            ${provider.rating}
            <#else>
            No rating yet
        </#if>
        </p>
    </div>
</div>

<!-- Stats Section -->
<div class="container section">
    <div class="bg-white p-4 rounded shadow-sm">
        <h3>Your Stats</h3>
        <table class="table table-bordered mt-3">
            <thead class="table-light">
            <tr>
                <th>Total Books</th>
                <th>Total Swaps</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${totalBooks}</td>
                <td>${totalSwaps}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- Edit Profile Form -->
<div class="container section">
    <div class="bg-white p-4 rounded shadow-sm">
        <h3>Edit Profile</h3>
        <form action="/provider/update/${provider.userId}" method="post">
            <div class="mb-3">
                <label for="username" class="form-label fw-bold">Username</label>
                <input type="text" id="username" name="username" class="form-control" value="${provider.username}" required>
            </div>
            <div class="mb-3">
                <label for="bio" class="form-label fw-bold">Bio</label>
                <textarea id="bio" name="bio" class="form-control" required>${provider.bio}</textarea>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label fw-bold">Name</label>
                <input type="text" id="name" name="name" class="form-control" value="${provider.name}" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>
    </div>
</div>

<!-- Delete Profile Button -->
<div class="container section">
    <div class="bg-white p-4 rounded shadow-sm">
        <form action="/provider/delete/${provider.userId}" method="post" onsubmit="return confirm('Are you sure you want to delete your profile?');">
            <button type="submit" class="btn btn-danger">Delete Profile</button>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="footer text-faded text-center py-4 bg-dark text-light mt-5">
    <div class="container">
        <p class="m-0 small">Copyright &copy; BookSwap Hub 2025</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function logout() {
        if (confirm("Are you sure you want to log out?")) {
            window.location.href = "/index.html";
        }
    }
</script>
</body>
</html>