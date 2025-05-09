package com.BookSwapHub.BookSwapHub.repository;

import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface
BookRepository extends JpaRepository<Book, Long> {

    // Get all books provided by a specific provider
    List<Book> findByProvider(User provider);

    // Custom query to find books by provider ID
    List<Book> findByProvider_UserId(Long UserId);

    //If multiple books, show up on different pages instead of one continous page
    Page<Book> findByGenreIgnoreCase(String genre, Pageable pageable);

    //Find the book by title
    Optional<Book> findByTitle(String title);

    @Query("SELECT COUNT(b) FROM Book b WHERE b.provider.userId = :providerId")
    long countByProviderId(@Param("providerId") Long providerId);

    @Modifying
    @Transactional
    @Query("DELETE FROM Book b WHERE b.provider.id = :providerId")
    void deleteAllByProviderId(@Param("providerId") Long providerId);


    List<Book> findAllByOwnerUserIdNot(Long userId);



}