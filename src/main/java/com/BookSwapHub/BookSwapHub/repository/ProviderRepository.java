package com.BookSwapHub.BookSwapHub.repository;

import com.BookSwapHub.BookSwapHub.model.Provider;
import org.springframework.data.jpa.repository.JpaRepository;


import java.util.Optional;


public interface ProviderRepository extends JpaRepository<Provider, Long> {

    // Find a provider by their username
    Optional<Provider> findByUsername(String username);

    Optional<Provider> findById(Long providerId);

    // Check if a provider exists by email
    boolean existsByEmail(String email);

    // Check if a provider exists by username
    boolean existsByUsername(String username);
}
