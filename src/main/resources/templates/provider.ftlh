<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Provider Profile - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,200,300,400,500,600,700,800,900" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body style="font-family: 'Raleway', sans-serif; background-color: #f8f9fa;">

<main>
    <header class="bg-dark text-light py-5 text-center">
        <h1 class="fw-bold text-uppercase">BookSwap Hub</h1>
        <h2 class="text-warning">Provider Profile</h2>
    </header>

    <nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark">
        <div class="container">
            <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/">BookSwap Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/home">Home</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/provider/manage">Manage Books</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/requests">Swap Requests</a></li>
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/${provider.userId}">Profile</a></li>
                    <a class="nav-link text-uppercase" href="/logout">Logout</a>
                </ul>
            </div>
        </div>
    </nav>

    <section class="container my-5">

        <!-- Profile Display -->
        <div class="bg-white p-4 rounded shadow-sm mb-4" id="providerInfo">
            <h3 class="text-dark">👤 Provider Information</h3>
            <p><strong>Username:</strong> ${provider.username}</p>
            <p><strong>Name:</strong> ${provider.name}</p>
            <p><strong>Email:</strong> ${provider.email}</p>
            <p><strong>Bio:</strong> ${provider.bio!''}</p>
            <p><strong>Rating:</strong> <#if provider.rating??>${provider.rating}<#else>No rating yet</#if></p>
        </div>

        <!-- Edit Form -->
        <div class="bg-white p-4 rounded shadow-sm mb-4">
            <h4 class="text-dark">✏️ Edit Profile</h4>
            <form action="/provider/update/${provider.userId}" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label fw-bold">Username</label>
                    <input type="text" id="username" name="username" class="form-control" value="${provider.username}" required>
                </div>
                <div class="mb-3">
                    <label for="bio" class="form-label fw-bold">Bio</label>
                    <textarea id="bio" name="bio" class="form-control" required>${provider.bio!""}</textarea>
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label fw-bold">Name</label>
                    <input type="text" id="name" name="name" class="form-control" value="${provider.name}" required>
                </div>
                <button type="submit" class="btn btn-warning">Save Changes</button> <!-- Save Changes Button -->
            </form>
        </div>

        <!-- Stats Section -->
        <div class="bg-white p-4 rounded shadow-sm mb-4">
            <h4 class="text-dark">📊 Stats</h4>
            <div class="row text-center">
                <div class="col-md-6">
                    <h5>Total Books</h5>
                    <p class="fs-4 fw-bold">${totalBooks}</p>
                </div>
                <div class="col-md-6">
                    <h5>Total Swaps</h5>
                    <p class="fs-4 fw-bold">${totalSwaps}</p>
                </div>
            </div>
        </div>

        <!-- Delete Profile -->
        <div class="bg-white p-4 rounded shadow-sm">
            <form action="/delete/${provider.userId}" method="post" onsubmit="return confirm('Are you sure you want to delete your profile?');">
                <button type="submit" class="btn btn-danger">Delete Profile</button>
            </form>
        </div>

    </section>
</main>

<footer class="footer text-center py-4 bg-dark text-light mt-auto border-top border-light">
    <div class="container">
        <p class="m-0 small">&copy; BookSwap Hub 2025</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="/js/scripts.js"></script>
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