package com.BookSwapHub.BookSwapHub.service;

import com.BookSwapHub.BookSwapHub.model.Provider;
import com.BookSwapHub.BookSwapHub.repository.ProviderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class ProviderService {

    @Autowired
    private ProviderRepository providerRepository;

    // Register a new provider
    public Provider registerProvider(Provider provider) {
        // Check if a provider with the same email or username already exists
        if (providerRepository.existsByEmail(provider.getEmail())) {
            throw new RuntimeException("Email is already in use");
        }

        if (providerRepository.existsByUsername(provider.getUsername())) {
            throw new RuntimeException("Username is already in use");
        }

        provider.setRole("Provider");
        // Save the new provider to the database
        return providerRepository.save(provider);
    }

    // Get provider by username
    public Optional<Provider> getProviderByUsername(String username) {

        return providerRepository.findByUsername(username);
    }

}