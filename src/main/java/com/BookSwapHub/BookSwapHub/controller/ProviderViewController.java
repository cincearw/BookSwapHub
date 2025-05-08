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
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

    @GetMapping("/provider/{id}")
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



    @GetMapping("/provider/home")
    public String providerDashboard(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/auth/login"; // fallback if not logged in
        }

        Provider provider = providerRepository.findById(userId).orElse(null);
        int newRequests = swapService.countNewRequestsForProvider(userId);

        model.addAttribute("provider", provider);
        model.addAttribute("newRequests", newRequests);

        return "provider-dashboard";
    }




    @PostMapping("/register")
    public String registerUser(@RequestParam String username,
                               @RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String password,
                               Model model) {
        if (userRepository.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email already registered.");
            return "login.ftlh";
        }

        User user = new User();
        user.setUsername(username);
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password); // Ideally hashed!

        userRepository.save(user);

        model.addAttribute("message", "Account created! Please log in.");
        return "login.ftlh";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }


    @GetMapping("/requests")
    public String viewRequests(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Provider provider = providerRepository.findById(userId).orElse(null);
        model.addAttribute("provider", provider);
        model.addAttribute("swapRequests", swapService.getSwapsByProvider(userId));
        return "swapRequests"; // maps to swaps.ftlh
    }


    @GetMapping("/provider/manage")
    public String manageBooks(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Provider provider = providerRepository.findById(userId).orElse(null);
        model.addAttribute("provider", provider);
        model.addAttribute("books", bookService.getBooksByProvider(userId));


        return "manage-books"; // maps to manage_books.ftlh
    }



    @GetMapping("/provider/add-book")
    public String showAddBookForm(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Provider provider = providerRepository.findById(userId).orElse(null);
        model.addAttribute("provider", provider);
        if (provider == null) {
            return "redirect:/login";  // Redirect to login if the user is not found
        }
        model.addAttribute("book", new Book());
        return "add-book";
    }

    @PostMapping("/provider/add-book")
    public String processAddBook(
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("genre") String genre,
            @RequestParam("description") String description,
            @RequestParam("image") MultipartFile image,
            HttpSession session
    ) {
        Long userId = (Long) session.getAttribute("userId");
        Provider provider = providerRepository.findById(userId).orElse(null);


        // Save uploaded image to /static/assets/img
        String relativePath = "src/main/resources/static/assets/img/";
        String fileName = System.currentTimeMillis() + "_" + image.getOriginalFilename();
        Path imagePath = Paths.get(relativePath + fileName);
        try {
            Files.createDirectories(imagePath.getParent());
            Files.write(imagePath, image.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/provider/add-book?error=image";
        }

        String imageUrl = "/assets/img/" + fileName;

        // Create and save the book
        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        book.setGenre(genre);
        book.setDescription(description);
        book.setImageUrl(imageUrl);
        book.setOwner(provider);

        bookService.addBook(book, userId);
        return "redirect:/provider/manage";
    }

    @GetMapping("/favicon.ico")
    @ResponseBody
    public void disableFavicon() {
        // no-op to prevent error
    }



}