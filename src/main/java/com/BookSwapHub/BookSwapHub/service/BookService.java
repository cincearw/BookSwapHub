package com.BookSwapHub.BookSwapHub.service;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.Provider;
import com.BookSwapHub.BookSwapHub.repository.BookRepository;
import com.BookSwapHub.BookSwapHub.repository.ProviderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BookService {
    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private ProviderRepository providerRepository;

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    //Used by provider to add book for swap request
    public Book addBook(Book book, Long userId) {
        Provider provider = providerRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Provider not found with id: " + userId));

        book.setProvider(provider);  // Associate the Provider with the Book
        return bookRepository.save(book);
    }

    public List<Book> getBooksByProvider(Long UserId) {
        return bookRepository.findByProvider_UserId(UserId);
    }
}
