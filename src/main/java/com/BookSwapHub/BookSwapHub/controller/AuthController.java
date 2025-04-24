package com.BookSwapHub.BookSwapHub.controller;

import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.Optional;

@RestController
@RequestMapping("/auth")
@CrossOrigin
public class AuthController {

    @Autowired
    private CustomerService userService;

    //signup endpoint
    @PostMapping("/signup")
    public User signup(@RequestBody User user){
        return userService.registerUser(user);
    }

    //simulate login by fetching user
    @GetMapping("/login/{username}")
    public Optional<User> login(@PathVariable String username){
        return userService.getUserByUsername(username);
    }
}