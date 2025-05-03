package com.BookSwapHub.BookSwapHub.service;

import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class CustomerService{
    @Autowired
    private UserRepository userRepository;

    public User registerUser(User user) {
        return userRepository.save(user); // works with Provider or User
    }


    public Optional<User> getUserByUsername(String username){
        return userRepository.findByUsername(username);
    }
}