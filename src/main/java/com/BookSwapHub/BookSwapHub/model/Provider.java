package com.BookSwapHub.BookSwapHub.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.List;

@Entity
public class Provider extends User{


    private String bio; // A short biography or description about the provider


    @OneToMany(mappedBy = "provider")
    @JsonManagedReference
    private List<Book> books; // Books provided by this provider


    public Provider() {
        super(); // Calls the constructor of the User class
    }


    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }


    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }
}
