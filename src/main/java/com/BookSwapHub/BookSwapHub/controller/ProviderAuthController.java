package com.BookSwapHub.BookSwapHub.controller;

import com.BookSwapHub.BookSwapHub.model.Provider;
import com.BookSwapHub.BookSwapHub.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Optional;

@RestController
@RequestMapping("/provider/auth")
@CrossOrigin
public class ProviderAuthController {

    @Autowired
    private ProviderService providerService;

    // Register a new provider
    @PostMapping("/register")
    public ResponseEntity<Provider> registerProvider(@RequestBody Provider provider) {
        try {
            Provider registeredProvider = providerService.registerProvider(provider);
            return new ResponseEntity<>(registeredProvider, HttpStatus.CREATED);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }

    // Simulate login by fetching provider by username
    @GetMapping("/login/Provider/{username}")
    public Optional<Provider> login(@PathVariable String username){
        return providerService.getProviderByUsername(username);
    }
}
