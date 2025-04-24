package com.BookSwapHub.BookSwapHub.controller;


import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.Provider;
import com.BookSwapHub.BookSwapHub.model.Review;
import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.repository.BookRepository;
import com.BookSwapHub.BookSwapHub.repository.ReviewRepository;
import com.BookSwapHub.BookSwapHub.repository.UserRepository;
import com.BookSwapHub.BookSwapHub.repository.SwapRepository;
import com.BookSwapHub.BookSwapHub.repository.ProviderRepository;
import com.BookSwapHub.BookSwapHub.service.BookService;
import com.BookSwapHub.BookSwapHub.service.ProviderService;
import com.BookSwapHub.BookSwapHub.service.ReviewService;
import com.BookSwapHub.BookSwapHub.service.SwapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Optional;

@Controller
public class ProviderViewController {

    @Autowired
    private ProviderRepository providerRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private SwapRepository swapRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProviderService providerService;

    @Autowired
    private BookService bookService;

    @Autowired
    private SwapService swapService;

    @GetMapping("/{id}")
    public String viewProvider(@PathVariable Long id, Model model) {
        Optional<Provider> optionalProvider = providerRepository.findById(id);
        if (optionalProvider.isPresent()) {
            Provider provider = optionalProvider.get();
            model.addAttribute("provider", provider);
            model.addAttribute("totalBooks", bookRepository.countByProviderId(id));
            model.addAttribute("totalSwaps", swapRepository.countByProviderId(id));
            return "provider";
        } else {
            return "error"; // Or redirect
        }
    }


    @PostMapping("/delete/{id}")
    public String deleteProvider(@PathVariable Long id) {
        providerRepository.deleteById(id);
        return "redirect:/"; // or to a goodbye page
    }

    @PostMapping("/update/{id}")
    public String updateProvider(@PathVariable Long id,
                                 @RequestParam String name,
                                 @RequestParam String email,
                                 @RequestParam String bio,
                                 @RequestParam String username) {
        providerRepository.findById(id).ifPresent(provider -> {
            provider.setName(name);
            provider.setEmail(email);
            provider.setBio(bio);
            provider.setUsername(username);
            providerRepository.save(provider);
        });
        return "redirect:/" + id;
    }


    @GetMapping("/user-dashboard")
    public String userDashboard(Model model) {
        return "user-dashboard";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String username,
                               @RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String password,
                               Model model) {
        if (userRepository.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email already registered.");
            return "user-dashboard";
        }

        User user = new User();
        user.setUsername(username);
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password); // Ideally hashed!

        userRepository.save(user);

        model.addAttribute("message", "Account created! Please log in.");
        return "user-dashboard";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            Model model) {

        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();

            if (user.getPassword().equals(password)) {
                // Check if this user is a provider
                Optional<User> userExist = userRepository.findByEmail(email);
                if (userExist.isPresent()) {
                    return "redirect:/" + user.getUserId(); // Redirect to /{id}
                } else {
                    // Not a provider, handle appropriately
                    model.addAttribute("error", "Login successful, but you're not a provider.");
                    return "user-dashboard";
                }
            } else {
                model.addAttribute("error", "Incorrect password.");
                return "user-dashboard";
            }
        } else {
            model.addAttribute("error", "No account found with that email.");
            return "user-dashboard";
        }
    }
}