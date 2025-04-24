package com.BookSwapHub.BookSwapHub.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "reviews")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_id")
    private Long reviewId;

    @ManyToOne
    @JoinColumn(name = "reviewer_id")
    private User reviewer;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;

    private LocalDate createdAt;
    private int rating;

    @Column(length = 250)
    private String comment;

    public Review(){
        this.createdAt = LocalDate.now();
    }

    //Getters & Setters

    public Long getReviewId() {
        return reviewId;
    }

    public User getReviewer() {
        return reviewer;
    }

    public Book getBook() {
        return book;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public int getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void setReviewer(User reviewer) {
        this.reviewer = reviewer;
    }

    public void setReviewId(Long reviewId) {
        this.reviewId = reviewId;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

}