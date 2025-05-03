<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,200,300,400,500,600,700,800,900" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-/1lmVZbAK1Rx0v4Z7N5rMF1FD6J8PlxOpfqpX6t13v6d1nR/6khkXeM2jLHLu4o3m+BF6ClnRj6vMgM2e/sWqw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/styles.css" />
</head>
<body class="bg-dark text-light d-flex justify-content-center align-items-center vh-100">

<div class="container text-center">
    <h1 class="text-warning">BookSwap Hub</h1>
    <h2 class="mb-4">Login</h2>

    <#-- Show error if login failed -->
    <#if error?? && error?has_content>
    <div class="alert alert-danger">${error}</div>
</#if>

<div class="bg-light text-dark p-4 rounded shadow-sm w-50 mx-auto">
    <form action="/auth/login" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="Enter Email" required>
        </div>

        <!-- Password field with Show button -->
        <div class="position-relative mb-3">
            <input type="password" id="password" name="password" class="form-control pe-5" placeholder="Enter Password" required>
            <button type="button"
                    onclick="togglePassword()"
                    class="btn btn-sm position-absolute top-50 end-0 translate-middle-y me-2"
                    style="background: none; border: none; color: #333;">
                Show
            </button>
        </div>
        <button type="submit" class="btn btn-warning w-100">Login</button>
        <div class="text-center mt-3">
            <p>Don't have an account? <a href="/auth/signup" class="text-warning fw-bold">Sign up here</a></p>
        </div>

    </form>
</div>
</div>

</body>
</html>

<script>
    function togglePassword() {
      const passwordField = document.getElementById("password");
      const toggleBtn = event.target;
      const isPassword = passwordField.type === "password";

      passwordField.type = isPassword ? "text" : "password";
      toggleBtn.textContent = isPassword ? "Hide" : "Show";
    }
</script>



