package com.BookSwapHub.BookSwapHub.service;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.repository.BookRepository;
import com.BookSwapHub.BookSwapHub.repository.UserRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DataFixService {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private UserRepository userRepository;

    @PostConstruct // Runs once at startup
    @Transactional
    public void assignOwnerToBooksWithNullOwner() {
        List<Book> booksWithoutOwner = bookRepository.findAll().stream()
                .filter(book -> book.getOwner() == null)
                .toList();

        if (booksWithoutOwner.isEmpty()) {
            System.out.println("✅ All books already have owners.");
            return;
        }

        // Use a specific user ID as fallback (e.g., admin or your test account)
        Long fallbackUserId = 1L;
        User fallbackOwner = userRepository.findById(fallbackUserId)
                .orElseThrow(() -> new RuntimeException("Fallback user not found with ID: " + fallbackUserId));

        for (Book book : booksWithoutOwner) {
            book.setOwner(fallbackOwner);
            bookRepository.save(book);
        }

        System.out.println("✅ Assigned fallback owner to " + booksWithoutOwner.size() + " book(s).");
    }
}

