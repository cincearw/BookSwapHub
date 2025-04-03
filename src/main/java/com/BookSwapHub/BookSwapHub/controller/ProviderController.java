package com.BookSwapHub.BookSwapHub.controller;

import com.BookSwapHub.BookSwapHub.model.*;
import com.BookSwapHub.BookSwapHub.service.BookService;
import com.BookSwapHub.BookSwapHub.service.MessageService;
import com.BookSwapHub.BookSwapHub.service.ReviewService;
import com.BookSwapHub.BookSwapHub.service.SwapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/provider")
@CrossOrigin
public class ProviderController {

    @Autowired
    private BookService bookService;

    @Autowired
    private SwapService swapService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private MessageService messageService;


    // Add a book
    @PostMapping("/books/{userId}")
    public ResponseEntity<Book> addBook(@PathVariable Long userId, @RequestBody Book book) {
        Book createdBook = bookService.addBook(book, userId);
        return new ResponseEntity<>(createdBook, HttpStatus.CREATED);
    }

    @GetMapping("/swaps/provider/{userId}")
    public List<Swap> getSwapsForProvider(@PathVariable Long userId) {
        return swapService.getSwapsByProvider(userId);
    }

    @GetMapping("/swaps/tied/{userId}")
    public List<Swap> getSwapsTiedToProviderBooks(@PathVariable Long userId) {
        return swapService.getSwapsForProviderBooks(userId);
    }

    // Get reviews by provider
    @GetMapping("/reviews/provider/{userId}")
    public List<Review> getReviewsByProvider(@PathVariable Long userId){
        return reviewService.getReviewsByProvider(userId);
    }

    // Get messages received by provider
    @GetMapping("/messages/received/{userId}")
    public List<Message> getMessagesByReceiver(@PathVariable Long userId) {
        return messageService.getMessagesByReceiver(userId);
    }

    // Get messages sent by provider
    @GetMapping("/messages/sent/{userId}")
    public List<Message> getMessagesBySender(@PathVariable Long userId) {
        return messageService.getMessagesBySender(userId);
    }

}
