package com.BookSwapHub.BookSwapHub.repository;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long> {

    // Get all books provided by a specific provider
    List<Book> findByProvider(User provider);

    // Custom query to find books by provider ID
    List<Book> findByProvider_UserId(Long UserId);
}