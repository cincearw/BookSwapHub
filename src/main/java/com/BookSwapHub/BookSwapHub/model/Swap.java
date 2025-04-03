package com.BookSwapHub.BookSwapHub.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "swaps")
public class Swap{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long swapId;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "requester_id")
    private User requester;

    @Column(length = 20)
    private String status; //"pending", "accepted"

    private LocalDate requestedAt;
    private LocalDate updatedAt;

    public Swap(){
        this.requestedAt = LocalDate.now();
        this.updatedAt = LocalDate.now();
        this.status = "pending";

    }

    //Getters & Setters
    public Long getSwapId(){
        return swapId;
    }

    public Book getBook() {
        return book;
    }

    public LocalDate getRequestedAt() {
        return requestedAt;
    }

    public LocalDate getUpdatedAt() {
        return updatedAt;
    }

    public String getStatus() {
        return status;
    }

    public User getRequester() {
        return requester;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public void setRequestedAt(LocalDate requestedAt) {
        this.requestedAt = requestedAt;
    }

    public void setRequester(User requester) {
        this.requester = requester;
    }

    public void setSwapId(Long swapId) {
        this.swapId = swapId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setUpdatedAt(LocalDate updatedAt) {
        this.updatedAt = updatedAt;
    }
}