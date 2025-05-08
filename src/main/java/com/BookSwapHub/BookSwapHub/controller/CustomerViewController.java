package com.BookSwapHub.BookSwapHub.controller;

import com.BookSwapHub.BookSwapHub.model.*;
import com.BookSwapHub.BookSwapHub.repository.BookRepository;
import com.BookSwapHub.BookSwapHub.repository.ReviewRepository;
import com.BookSwapHub.BookSwapHub.repository.UserRepository;
import com.BookSwapHub.BookSwapHub.service.BookService;
import com.BookSwapHub.BookSwapHub.service.MessageService;
import com.BookSwapHub.BookSwapHub.service.ReviewService;
import com.BookSwapHub.BookSwapHub.service.SwapService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class CustomerViewController {

    @Autowired
    private BookService bookService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private SwapService swapService;

    @Autowired
    private MessageService messageService;



    @GetMapping("/library")
    public String showLibrary(
            @RequestParam(required = false) String genre,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size,
            Model model,
            HttpSession session) {

        Page<Book> bookPage;
        if (genre != null && !genre.isEmpty()) {
            bookPage = bookService.getBooksByGenrePaginated(genre, PageRequest.of(page, size));
        } else {
            bookPage = bookService.getAllBooksPaginated(PageRequest.of(page, size));
        }

        model.addAttribute("books", bookPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", bookPage.getTotalPages());
        model.addAttribute("genre", genre);
        model.addAttribute("genres", bookService.getAllGenres());
        model.addAttribute("userId", session.getAttribute("userId"));

        return "book-list";
    }



    @GetMapping("/reviews")
    public String showReviewPage(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("loggedInUsername", loggedInUser.getUsername());
        model.addAttribute("books", bookRepository.findAll());
        model.addAttribute("reviews", reviewService.getReviewsByUser(loggedInUser.getUserId()));
        return "review-page";
    }






    @PostMapping("/reviews")
    public String submitReview(@RequestParam String username,
                               @RequestParam Long bookId,
                               @RequestParam int rating,
                               @RequestParam String comment) {

        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new RuntimeException("Book not found"));

        Review review = new Review();
        review.setReviewer(user);
        review.setBook(book);
        review.setRating(rating);
        review.setComment(comment);
        review.setCreatedAt(LocalDate.now());

        reviewRepository.save(review);
        return "redirect:/reviews";
    }



    @GetMapping("/books/{bookId}/reviews")
    public String showBookReviews(@PathVariable Long bookId, Model model) {
        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new RuntimeException("Book not found with id: " + bookId));

        List<Review> reviews = reviewService.getReviewsByBook(book);
        model.addAttribute("book", book);
        model.addAttribute("reviews", reviews);

        return "book-reviews"; // will point to book-reviews.ftlh
    }


    @GetMapping("/customer/dashboard")
    public String customerDashboard(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/auth/login";
        }

        User user = userRepository.findById(userId).orElse(null);
        int pendingSwaps = swapService.countPendingSwapsByUserId(userId);
        int acceptedSwaps = swapService.countAcceptedSwapsByUserId(userId);
        int messages = messageService.countUnreadMessagesForUser(userId);

        model.addAttribute("user", user);
        model.addAttribute("pendingSwaps", pendingSwaps);
        model.addAttribute("acceptedSwaps", acceptedSwaps);
        model.addAttribute("messages", messages);

        return "customer-dashboard";
    }

    @GetMapping("/swaps")
    public String showSwapsPage(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/auth/login";
        }

        List<Swap> swaps = swapService.getSwapsByUser(userId);

        List<Swap> pendingSwaps = swaps.stream()
                .filter(swap -> "pending".equalsIgnoreCase(swap.getStatus()))
                .toList();

        List<Swap> acceptedSwaps = swaps.stream()
                .filter(swap -> "accepted".equalsIgnoreCase(swap.getStatus()))
                .toList();

        model.addAttribute("pendingSwaps", pendingSwaps);
        model.addAttribute("acceptedSwaps", acceptedSwaps);

        return "swaps"; // resolves to swaps.ftlh
    }



    @GetMapping("/messages")
    public String showMessages(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/auth/login";
        }

        User user = userRepository.findById(userId).orElseThrow();
        model.addAttribute("inbox", messageService.getMessagesByReceiver(userId));
        model.addAttribute("sent", messageService.getMessagesBySender(userId));

        List<Book> availableBooks = bookRepository.findAllByOwnerUserIdNot(userId);// Exclude own books
        model.addAttribute("availableBooks", availableBooks);

        return "messages";
    }


    @PostMapping("/messages/send")
    public String sendMessage(@RequestParam String bookTitle,
                              @RequestParam String content,
                              HttpSession session) {
        Long senderId = (Long) session.getAttribute("userId");
        if (senderId == null) {
            return "redirect:/auth/login";
        }

        User sender = userRepository.findById(senderId)
                .orElseThrow(() -> new RuntimeException("Sender not found"));

        Book targetBook = bookRepository.findByTitle(bookTitle)
                .orElseThrow(() -> new RuntimeException("Book not found"));

        User receiver = targetBook.getOwner();

        Message message = new Message();
        message.setSender(sender);
        message.setReceiver(receiver);
        message.setContent(content);
        message.setCreatedAt(LocalDate.now());
        message.setStatus("unread");

        messageService.sendMessage(message);

        return "redirect:/messages";
    }


    @PostMapping("/messages/delete/{messageId}")
    public String deleteMessage(@PathVariable Long messageId) {
        messageService.deleteMessageById(messageId); // You’ll add this in the service
        return "redirect:/messages";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String name,
                                @RequestParam(required = false) String bio,
                                @RequestParam(required = false) String favoriteGenres,
                                HttpSession session,
                                Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/auth/login";
        }

        User user = userRepository.findById(userId).orElseThrow();

        user.setName(name);
        user.setBio(bio); // treat this as "location"
        user.setFavoriteGenres(favoriteGenres);
        userRepository.save(user);

        // Add confirmation
        model.addAttribute("successMessage", "Profile updated successfully!");

        // Refresh values
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy");
        String formattedDate = user.getCreatedAt().format(formatter);
        model.addAttribute("user", user);
        model.addAttribute("memberSince", formattedDate);

        return "profile";
    }



    @GetMapping("/profile")
    public String showProfilePage(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/auth/login";
        }

        User user = userRepository.findById(userId).orElseThrow();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy");

        // Add this line for formatted "Member Since"
        String formattedDate = user.getCreatedAt().format(formatter);

        model.addAttribute("user", user);
        model.addAttribute("memberSince", formattedDate);


        return "profile"; // profile.ftlh
    }














}
