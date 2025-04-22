package com.BookSwapHub.BookSwapHub.model;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

@Entity
@Table(name = "books")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Book{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonBackReference
    private Provider provider;

    @Column(length = 100)
    private String title;

    @Column(length = 100)
    private String author;

    @Column(length = 30)
    private String genre;

    @Column(length = 250)
    private String description;

    @ManyToOne
    @JoinColumn(name = "ownerId") //FK to Users table
    private User owner;


    @Column(length = 350)
    private String imageUrl;

    //Constructors
    public Book(){}

    //Getters & Setters
    public Long getBookId(){
        return bookId;
    }

    public Provider getProvider() {
        return provider;
    }

    public String getAuthor() {
        return author;
    }

    public String getDescription() {
        return description;
    }

    public String getGenre() {
        return genre;
    }

    public String getTitle() {
        return title;
    }

    public User getOwner() {
        return owner;
    }

    public void setBookId(Long bookId) {
        this.bookId = bookId;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}