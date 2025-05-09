package com.BookSwapHub.BookSwapHub.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@Table(name = "users")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @OneToMany(mappedBy = "sender", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Message> messagesSent;


    private String name;

    @Column(length = 50)
    private String email;

    @Column(length = 20, unique = true)
    private String username;

    @Column(length = 50)
    private String password;

    @Column(length = 10)
    private String role; //"Customer" or "Provider"

    private LocalDate createdAt;

    private String bio;

    private String favoriteGenres;

    //Constructors
    public User(){this.createdAt = LocalDate.now();} //set default

    //Getters and Setters
    public Long getUserId(){
        return userId;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public String getRole() {
        return role;
    }

    public String getUsername() {
        return username;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public String getBio(){ return bio; }

    public String getFavoriteGenres() {
        return favoriteGenres;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public void setFavoriteGenres(String favoriteGenres) {
        this.favoriteGenres = favoriteGenres;
    }

    public List<Message> getMessagesSent() {
        return messagesSent;
    }

    public void setMessagesSent(List<Message> messagesSent) {
        this.messagesSent = messagesSent;
    }

}