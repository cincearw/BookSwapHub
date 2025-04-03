package com.BookSwapHub.BookSwapHub.service;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.Review;
import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.repository.BookRepository;
import com.BookSwapHub.BookSwapHub.repository.ReviewRepository;
import com.BookSwapHub.BookSwapHub.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookRepository bookRepository;

    public Review submitReview(Review review){
        User reviewer = userRepository.findById(review.getReviewer().getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Book book = bookRepository.findById(review.getBook().getBookId())
                .orElseThrow(() -> new RuntimeException("Book not found"));

        review.setReviewer(reviewer);
        review.setBook(book);
        review.setCreatedAt(LocalDate.now());

        return reviewRepository.save(review);
    }

    public List<Review> getReviewsByUser(Long userId){
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return reviewRepository.findByReviewer(user);
    }

    public void deleteReview(Long reviewId){
        reviewRepository.deleteById(reviewId);
    }


    // Get reviews for books provided by a specific provider
    public List<Review> getReviewsByProvider(Long userId) {
        // Fetch provider
        User provider = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Provider not found with id: " + userId));

        // Fetch books provided by the provider
        List<Book> providerBooks = bookRepository.findByProvider(provider);

        // Collect reviews for those books
        List<Review> reviews = new ArrayList<>();
        for (Book book : providerBooks) {
            reviews.addAll(reviewRepository.findByBook(book));
        }

        return reviews;
    }

}
