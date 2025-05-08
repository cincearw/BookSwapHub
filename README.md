# BookSwap Hub

## Title
> BookSwap Hub

## Team Members
> Cincear Weaver and Saniyah Khan 

## Description 
> BookSwap Hub is a community-driven app designed to facilitate book exchanges between users. The motivation behind this app is to promote
> reading, sustainability, and accessibility by enabling users to share books they no longer need and find books they want to read without
> purchasing new copies. The app aims to create a network of book lovers who can easily swap books, leave reviews, and connect with other readers.
> 
> Some of the services provided within the application are:
- > Book exchange platform where users can list books they own and search for books they want.
- > A user-friendly messaging system for coordinating book swaps.
- > Review and rating system for books and swapping experiences.
- > Admin moderation to ensure a safe and fair exchange environment.

## App Functions
1. Customer (the user looking to swap books):
    1. Create/modify customer profile - Users can set up a profile with their book preferences, location, and swap history.
    2. View available Books - Users can browse available books listed by other members in the community.
    3. Request Book Swaps - Users can request a swap by contacting the book owner through an in-app messaging system.
    4. Write reviews - Users can leave reviews on books they have received and provide feedback on their swapping experience.
    5. Send, Receive, and Delete messages - Users can send, receive, and delete messages to providers.
    6. View Swap Status - Users can see their swap status, 'pending,' or 'accepted'. 
       
2. Provider (the user offering books for swap):
    1. Create/modify/remove Book Listings - Users can list books they want to swap, update descriptions, and remove books when no longer available.
    2. Manage Swap Requests - Users can accept, reject, or negotiate book swap requests.
    3. View Swap statistics -  Users can track how many books they have swapped and any pending requests.
    4. Reply to reviews - Users can respond to feedback left by those who have received books from them.
  

## Setup Instructions

1. Start MySQL and open phpMyAdmin
2. Create a database named `bookswap3`
3. Import the sample data using:
   - phpMyAdmin: Go to `Import`, select `db/bookswap3.sql`, and execute.
   - OR CLI: `mysql -u root -p bookswap3 < db/bookswap3.sql`

This sets up the system with example users, books, messages, swaps, and reviews.

## Getting Started

To run the application:

1. Clone the repository and open the project in your IDE.
2. Ensure your MySQL database is running and import the provided `bookswap3.sql` file located in `/db`.
3. Run the Spring Boot application.
4. Access the app via `http://localhost:8080/index.html`, if you want to see the BookSwap Hub Website. If not, go to `http://localhost:8080/auth/login`, to explore our website. 


## Default Accounts

These accounts can be used for quick login during testing:

### Customer
- **Email:** `sk@example.com`  
- **Password:** `1234`

- **Email:** `cute123@gmail.com`
- **Password:** `blahblah123`


### Provider
- **Email:** `pro123@gmail.com`  
- **Password:** `pro123`

## Demo Scenario

### Provider: Create profile & list a book
- Provider **P1** visits `/auth/signup` and registers using the invite code `PROVIDER2025`.
- P1 creates their profile with name, email, and location.
- P1 adds a book (e.g., _To Kill a Mockingbird_, genre: Fiction).
- P1 logs out.

---

### Customer: Create profile, browse library, and view reviews
- Customer **C1** signs up via `/auth/signup`.
- C1 logs in and is redirected to `/customer/dashboard`.
- C1 browses books via `/library` and selects a book from P1.
- C1 views book details and reviews.

---

### Customer: Write reviews
- **C2** signs up, logs in, and requests a swap for a book.
- After the swap is completed, C2 visits `/reviews` and writes a positive review.

---

### Provider: Respond to messages and update profile
- P1 logs in and visits `/provider/{id}` to read reviews.
- P1 replies to any messages from requesters.
- P1 views book swap statistics.
- P1 updates their profile bio or favorite genres and logs out.

---

### Customer: Send and manage messages
- C1 sends a message to P1 via `/messages`.
- P1 views and replies through their own inbox.
- C1 logs in again and deletes the message after reading.

---

### Customer: Request and track swaps
- C1 initiates a book swap.
- The swap is shown as **pending**.
- P1 logs in and marks the request as **accepted**.
- C1 later sees the accepted status under `/swaps`.

---

## Features Demonstrated

### Customer Use Cases
- Create/modify profile  
- View books and reviews  
- Send, receive, and delete messages  
- Request book swaps  
- Write and view reviews from self and other users  
- View swap status  

### Provider Use Cases
- Register and create profile  
- Add/manage book listings  
- Respond to reviews  
- Read messages
-  View statistics  

---


  

