package com.BookSwapHub.BookSwapHub.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.List;

@Entity
public class Provider extends User{




    @OneToMany(mappedBy = "provider")
    @JsonManagedReference
    private List<Book> books; // Books provided by this provider


    public Provider() {
        super(); // Calls the constructor of the User class
    }


    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }
}
