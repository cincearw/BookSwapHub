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
        //Find the actual User from the database using the userId from the submitted review
        User reviewer = userRepository.findById(review.getReviewer().getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        //find the actual book from the database using the bookId from the submitted review
        Book book = bookRepository.findById(review.getBook().getBookId())
                .orElseThrow(() -> new RuntimeException("Book not found"));

        //attach to the managed user entity and book entity to the review
        review.setReviewer(reviewer);
        review.setBook(book);
        review.setCreatedAt(LocalDate.now());

        return reviewRepository.save(review);
    }

    //return a list of all reviews in the dataabase made by that userId
    public List<Review> getReviewsByUser(Long userId){
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return reviewRepository.findByReviewer(user);
    }
//delete the review
    public void deleteReview(Long reviewId){
        reviewRepository.deleteById(reviewId);
    }

    public List<Review> getAllReviews() {
        return reviewRepository.findAll();
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

    public List<Review> getReviewsByBook(Book book) {
        return reviewRepository.findByBook(book);
    }

}
