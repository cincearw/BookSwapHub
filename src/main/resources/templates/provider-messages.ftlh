<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Messages - BookSwap Hub</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark py-lg-4 bg-dark">
    <div class="container">
        <a class="navbar-brand text-uppercase fw-bold d-lg-none" href="/provider/dashboard">BookSwap Hub</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/home">Home</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase active" href="/provider/messages">Messages</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/manage">Manage Books</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/requests">Swap Requests</a></li>
                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/provider/${provider.userId}">Profile</a></li>
                <a class="nav-link text-uppercase" href="/logout">Logout</a>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-5 mb-5">
    <h2 class="text-center text-warning">Provider Messages</h2>
    <p class="text-center text-light">View and manage customer messages, and reply to their queries.</p>

    <div class="text-end mb-3">
        <button class="btn btn-warning" onclick="showNewMessageForm()">New Message</button>
    </div>

    <!-- Tabs -->
    <ul class="nav nav-tabs mb-3" id="messageTabs">
        <li class="nav-item">
            <a class="nav-link active" id="inbox-tab" data-bs-toggle="tab" href="#inbox">Inbox</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="sent-tab" data-bs-toggle="tab" href="#sent">Sent</a>
        </li>
    </ul>

    <div class="tab-content">
        <!-- Inbox Tab -->
        <div class="tab-pane fade show active" id="inbox">
            <div class="bg-light p-4 rounded shadow" style="max-height: 400px; overflow-y: auto;">
                <h5 class="text-dark">Customer Messages</h5>
                <div class="list-group">
                    <#list inbox as msg>
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <strong>From: ${msg.sender.name}</strong>
                            <p>"${msg.content}"</p>
                            <small class="text-muted d-block">${msg.formattedCreatedAt}</small>
                        </div>
                        <div>
                            <!-- Reply Button -->
                            <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#replyModal${msg.messageId}">Reply</button>
                            <!-- Delete Button -->
                            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModalInbox${msg.messageId}">Delete</button>
                        </div>
                    </div>

                    <!-- Inbox Reply Modal -->
                    <div class="modal fade" id="replyModal${msg.messageId}" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Reply to ${msg.sender.name}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="/messages/reply">
                                        <input type="hidden" name="receiverId" value="${msg.sender.userId}" />
                                        <div class="mb-3">
                                            <label for="replyContent" class="form-label">Your Reply</label>
                                            <textarea name="content" id="replyContent" class="form-control" rows="4" placeholder="Type your reply here..." required></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-success">Send Reply</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inbox Delete Modal -->
                    <div class="modal fade" id="deleteModalInbox${msg.messageId}" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Confirm Deletion</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">Are you sure you want to delete this message?</div>
                                <div class="modal-footer">
                                    <form method="post" action="/provider/messages/delete/${msg.messageId}">
                                        <button type="submit" class="btn btn-danger">Yes, Delete</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
    </div>
</div>

<!-- Sent Tab -->
<div class="tab-pane fade" id="sent">
    <div class="bg-light p-4 rounded shadow" style="max-height: 400px; overflow-y: auto;">
        <h5 class="text-dark">Sent Messages</h5>
        <div class="list-group">
            <#list sent as msg>
            <div class="list-group-item d-flex justify-content-between align-items-center">
                <div>
                    <strong>You → ${msg.receiver.name}:</strong> "${msg.content}"
                    <small class="text-muted d-block">${msg.formattedCreatedAt}</small>
                </div>
                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModalSent${msg.messageId}">Delete</button>
            </div>

            <!-- Sent Delete Modal -->
            <div class="modal fade" id="deleteModalSent${msg.messageId}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Confirm Deletion</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">Are you sure you want to delete this message?</div>
                        <div class="modal-footer">
                            <form method="post" action="/provider/messages/delete/${msg.messageId}">
                                <button type="submit" class="btn btn-danger">Yes, Delete</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </#list>
    </div>
</div>
</div>
</div>

<!-- New Message Form -->
<div class="container mt-4" id="newMessageForm" style="display: none;">
    <div class="bg-light p-4 rounded shadow">
        <h5 class="text-dark">New Message</h5>
        <form method="post" action="/messages/reply" id="messageForm">
            <div class="mb-3">
                <label for="bookTitle" class="form-label">Book Title</label>
                <select id="bookTitle" name="bookTitle" class="form-select" required>
                    <#if availableBooks?has_content>
                    <#list availableBooks as book>
                    <option value="${book.title}">${book.title} by ${book.author}</option>
                </#list>
                <#else>
                <option disabled selected>No books available</option>
            </#if>
            </select>
    </div>

    <div class="mb-3">
        <label for="messageText" class="form-label">Message</label>
        <textarea name="content" id="messageText" class="form-control" rows="4" placeholder="Type your message here..." required></textarea>
    </div>
    <button type="submit" class="btn btn-success">Send Message</button>
    <button type="button" class="btn btn-secondary" onclick="hideNewMessageForm()">Cancel</button>
    </form>
</div>
</div>
</div>

<!-- Footer -->
<footer class="footer mt-auto text-center py-4 bg-dark text-light border-top border-light">
    <div class="container">
        <p class="m-0 small">&copy; BookSwap Hub 2025</p>
    </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showNewMessageForm() {
        document.getElementById("newMessageForm").style.display = "block";
    }

    function hideNewMessageForm() {
        document.getElementById("newMessageForm").style.display = "none";
    }
</script>

</body>
</html>