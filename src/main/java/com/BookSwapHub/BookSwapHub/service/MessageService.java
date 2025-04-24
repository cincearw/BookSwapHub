package com.BookSwapHub.BookSwapHub.service;
import com.BookSwapHub.BookSwapHub.model.Message;
import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.repository.MessageRepository;
import com.BookSwapHub.BookSwapHub.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class MessageService {
    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private UserRepository userRepository;

    public Message sendMessage(Message message) {
        User sender = userRepository.findById(message.getSender().getUserId())
                .orElseThrow(() -> new RuntimeException("Sender not found"));

        User receiver = userRepository.findById(message.getReceiver().getUserId())
                .orElseThrow(() -> new RuntimeException("Receiver not found"));

        message.setSender(sender);
        message.setReceiver(receiver);
        message.setCreatedAt(LocalDate.now());
        message.setStatus("unread");

        return messageRepository.save(message);
    }

    public List<Message> getMessagesByReceiver(Long receiverId) {
        User receiver = userRepository.findById(receiverId)
                .orElseThrow(() -> new RuntimeException("Receiver not found"));
        return messageRepository.findByReceiver(receiver);
    }

    public List<Message> getMessagesBySender(Long senderId) {
        User sender = userRepository.findById(senderId)
                .orElseThrow(() -> new RuntimeException("Sender not found"));
        return messageRepository.findBySender(sender);
    }
}
