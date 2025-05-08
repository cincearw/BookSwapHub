package com.BookSwapHub.BookSwapHub.controller;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.Message;
import com.BookSwapHub.BookSwapHub.model.Review;
import com.BookSwapHub.BookSwapHub.model.Swap;
import com.BookSwapHub.BookSwapHub.service.BookService;
import com.BookSwapHub.BookSwapHub.service.MessageService;
import com.BookSwapHub.BookSwapHub.service.ReviewService;
import com.BookSwapHub.BookSwapHub.service.SwapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/auth")
@CrossOrigin
public class CustomerController {
    @Autowired
    private BookService bookService;

    @Autowired
    private SwapService swapService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private MessageService messageService;

    @GetMapping("/books")
    public List<Book> viewAllBooks(){
        return bookService.getAllBooks();
    }

    //submit a new swap
    @PostMapping("/swaps")
    public ResponseEntity<Swap> requestSwap(@RequestBody Swap swap){
        Swap createdSwap = swapService.createSwap(swap);
        return new ResponseEntity<>(createdSwap, HttpStatus.CREATED);
    }

    //Get swaps for a customer
    @GetMapping("/swaps/user/{userId}")
    public List<Swap> getSwapsByUser(@PathVariable Long userId){
        return swapService.getSwapsByUser(userId);
    }

    @PutMapping("/swaps/{swapId}/status")
    public ResponseEntity<Swap> updateSwapStatus(@PathVariable Long swapId, @RequestParam String status) {
        Swap updatedSwap = swapService.updateSwapStatus(swapId, status);
        return ResponseEntity.ok(updatedSwap);
    }


    @PostMapping("/reviews")
    public Review submitReview(@RequestBody Review review){
        return reviewService.submitReview(review);
    }

    @GetMapping("/reviews/user/{userId}")
    public List<Review> getReviewsByUser(@PathVariable Long userId){
        return reviewService.getReviewsByUser(userId);
    }

    @DeleteMapping("/reviews/{reviewId}")
    public void deleteReview(@PathVariable Long reviewId){
        reviewService.deleteReview(reviewId);
    }

    //messages for customer
    @PostMapping("/messages")
    public Message sendMessage(@RequestBody Message message) {
        return messageService.sendMessage(message);
    }

    @GetMapping("/messages/received/{userId}")
    public List<Message> getMessagesByReceiver(@PathVariable Long userId) {
        return messageService.getMessagesByReceiver(userId);
    }

    @GetMapping("/messages/sent/{userId}")
    public List<Message> getMessagesBySender(@PathVariable Long userId) {
        return messageService.getMessagesBySender(userId);
    }

}