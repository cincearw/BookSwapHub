package com.BookSwapHub.BookSwapHub.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "messages")
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long messageId;

    @ManyToOne
    @JoinColumn(name = "sender_id")
    private User sender;

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    private User receiver;

    @Column(length = 200)
    private String content;

    private LocalDate createdAt;

    @Column(length = 20)
    private String status; // "read", "unread", etc.

    @Transient
    private String formattedCreatedAt;

    public Message() {
        this.createdAt = LocalDate.now();
        this.status = "unread";
    }

    // Getters & Setters
    public Long getMessageId() { return messageId; }
    public User getSender() { return sender; }
    public User getReceiver() { return receiver; }
    public String getContent() { return content; }
    public LocalDate getCreatedAt() { return createdAt; }
    public String getStatus() { return status; }
    public String getFormattedCreatedAt() { return formattedCreatedAt; }

    public void setMessageId(Long messageId) { this.messageId = messageId; }
    public void setSender(User sender) { this.sender = sender; }
    public void setReceiver(User receiver) { this.receiver = receiver; }
    public void setContent(String content) { this.content = content; }
    public void setCreatedAt(LocalDate createdAt) { this.createdAt = createdAt; }
    public void setStatus(String status) { this.status = status; }
    public void setFormattedCreatedAt(String formattedCreatedAt) {this.formattedCreatedAt = formattedCreatedAt; }

}
