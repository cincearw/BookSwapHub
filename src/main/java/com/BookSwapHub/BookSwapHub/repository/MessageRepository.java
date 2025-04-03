package com.BookSwapHub.BookSwapHub.repository;

import com.BookSwapHub.BookSwapHub.model.Message;
import com.BookSwapHub.BookSwapHub.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findByReceiver(User receiver);
    List<Message> findBySender(User sender);
}
