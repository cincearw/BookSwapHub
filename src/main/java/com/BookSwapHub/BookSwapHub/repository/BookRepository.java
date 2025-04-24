package com.BookSwapHub.BookSwapHub.repository;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BookRepository extends JpaRepository<Book, Long> {

    // Get all books provided by a specific provider
    List<Book> findByProvider(User provider);

    // Custom query to find books by provider ID
    List<Book> findByProvider_UserId(Long UserId);

    //If multiple books, show up on different pages instead of one continous page
    Page<Book> findByGenreIgnoreCase(String genre, Pageable pageable);

    //Find the book by title
    Optional<Book> findByTitle(String title);

}