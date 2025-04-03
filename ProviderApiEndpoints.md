## API Endpoints

| Method | Endpoint        | Description                     | Example Request Body |
|--------|---------------|---------------------------------|----------------------|
| POST   | /provider/auth/register    | Provider Registration           | `{"name": "John Doe", "username": "johndoe", "email": "johndoe@example.com", "password": "securepassword", "role": "provider", "bio": "An enthusiastic book provider."}`                  |
| GET    | /provider/auth/login/provider/{username}| Provider Login     | N/A                  |
| GET    | /provider/messages/sent/{userId}| Get Sent Messages          | N/A |
| GEt    | /provider/messages/received/{userId}   |Get Received Messages| N/A |
| GEt    | /provider/swaps/tied/{userId}    | Get Swaps Tied to Provider's Books        | N/A                  |
| GEt    | /provider/swaps/provider/{userId}    | Get Provider's Swaps        | N/A                  |
| POST    | /provider/books/{userId}    | Add a Book        | `{ "title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "genre": "Classic", "description": "A novel set in the 1920s about the mysterious millionaire Jay Gatsby."}`                  |
