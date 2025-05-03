package com.BookSwapHub.BookSwapHub.controller;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.Review;
import com.BookSwapHub.BookSwapHub.model.User;
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
            Model model) {

        Page<Book> bookPage;
        if (genre != null && !genre.isEmpty()) {
            bookPage = bookService.getBooksByGenrePaginated(genre, PageRequest.of(page, size));
        } else {
            bookPage = bookService.getAllBooksPaginated(PageRequest.of(page, size));
        }

        model.addAttribute("books", bookPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", bookPage.getTotalPages());
        model.addAttribute("genre", genre); // to keep selection active
        model.addAttribute("genres", bookService.getAllGenres()); // optional: distinct list of genres
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
        model.addAttribute("reviews", reviewService.getAllReviews());
        return "review-page";
    }



    @PostMapping("/reviews")
    public String submitReview(
            @RequestParam String username,
            @RequestParam String bookTitle,
            @RequestParam int rating,
            @RequestParam String comment) {

        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Book book = bookRepository.findByTitle(bookTitle)
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





}
