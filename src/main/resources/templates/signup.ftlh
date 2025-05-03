<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - BookSwap Hub</title>
    <link rel="stylesheet" href="/css/styles.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light d-flex justify-content-center align-items-center vh-100">

<div class="container text-center">
    <h1 class="text-warning">BookSwap Hub</h1>
    <h2 class="mb-4">Sign Up</h2>

    <div class="bg-light text-dark p-4 rounded shadow-sm w-50 mx-auto">
        <form action="/auth/signup" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="Enter Username" required>
            </div><div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" id="name" name="name" class="form-control" placeholder="Enter Full Name" required>
        </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="Enter Email" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Enter Password" required>
            </div>
            <div class="mb-3">
                <label for="role" class="form-label">Sign Up As</label>
                <select id="role" name="role" class="form-select">
                    <option value="Customer">Customer</option>
                    <option value="Provider">Provider</option>
                </select>
            </div>

            <div class="mb-3" id="inviteCodeContainer" style="display: none;">
                <label for="inviteCode" class="form-label">Provider Invite Code</label>
                <input type="text" id="inviteCode" name="inviteCode" class="form-control" placeholder="Enter your invite code">
            </div>

            <button type="submit" class="btn btn-warning w-100">Sign Up</button>
        </form>
    </div>
</div>

<script>
    document.getElementById("role").addEventListener("change", function () {
      const inviteCodeContainer = document.getElementById("inviteCodeContainer");
      inviteCodeContainer.style.display = this.value === "Provider" ? "block" : "none";
    });
</script>

</body>
</html>
