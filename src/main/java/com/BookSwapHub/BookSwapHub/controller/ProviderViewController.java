package com.BookSwapHub.BookSwapHub.controller;


import com.BookSwapHub.BookSwapHub.model.Book;
import com.BookSwapHub.BookSwapHub.model.Provider;
import com.BookSwapHub.BookSwapHub.model.Review;
import com.BookSwapHub.BookSwapHub.model.Message;
import com.BookSwapHub.BookSwapHub.service.MessageService;
import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.model.Swap;
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
    private MessageService messageService;

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
    public String viewProvider(@PathVariable Long id, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Optional<User> optionalProvider = userRepository.findById(userId);
        if (optionalProvider.isPresent()) {
            User provider = optionalProvider.get();
            model.addAttribute("provider", provider);
            model.addAttribute("totalBooks", bookRepository.countByProviderId(userId));
            model.addAttribute("totalSwaps", swapRepository.countByProviderId(userId));
            return "provider";
        } else {
            return "error";
        }
    }


    @PostMapping("/delete/{id}")
    public String deleteProvider(@PathVariable Long id, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        providerRepository.deleteById(userId);
        return "index.html";
    }


    @PostMapping("/provider/deleteBook/{id}")
    public String deleteBook(@PathVariable Long id) {
        Optional<Book> book = bookRepository.findById(id);
        if (book.isPresent()) {
            bookRepository.delete(book.get());
        }
        return "redirect:/provider/manage";
    }

    @PostMapping("provider/update/{id}")
    public String updateProvider(@PathVariable Long id,
                                 @RequestParam String name,
                                 @RequestParam(required = false) String bio,
                                 @RequestParam String username,
                                 HttpSession session,
                                 Model model) {
        Long userId = (Long) session.getAttribute("userId");
        User provider = userRepository.findById(userId).orElseThrow();
            provider.setName(name);
            provider.setBio(bio);
            provider.setUsername(username);
            userRepository.save(provider);

            model.addAttribute("provider", provider);
        model.addAttribute("totalBooks", bookRepository.countByProviderId(userId));
        model.addAttribute("totalSwaps", swapRepository.countByProviderId(userId));



        return "provider";
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
        return "swapRequests";
    }


    @GetMapping("/provider/manage")
    public String manageBooks(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Provider provider = providerRepository.findById(userId).orElse(null);
        model.addAttribute("provider", provider);
        model.addAttribute("books", bookService.getBooksByProvider(userId));
        model.addAttribute("bookList", bookRepository.findById(userId));


        return "manage-books";
    }


    @GetMapping("/provider/add-book")
    public String showAddBookForm(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Provider provider = providerRepository.findById(userId).orElse(null);
        model.addAttribute("provider", provider);
        if (provider == null) {
            return "redirect:/login";
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
            HttpSession session,
            Model model
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
        model.addAttribute("bookList", bookRepository.findById(userId));
        model.addAttribute("provider", provider);
        model.addAttribute("totalBooks", bookRepository.countByProviderId(userId));
        model.addAttribute("totalSwaps", swapRepository.countByProviderId(userId));
        return "redirect:/provider/manage";
    }



    @GetMapping("/provider/editBook/{bookId}")
    public String showEditBookForm(@PathVariable Long bookId, Model model) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new RuntimeException("Book not found"));
        model.addAttribute("book", book);
        return "edit-book"; // Template file you'll create next
    }

    @PostMapping("/provider/editBook/{bookId}")
    public String processEditBook(@PathVariable Long bookId,
                                  @RequestParam String title,
                                  @RequestParam String author,
                                  @RequestParam String genre,
                                  @RequestParam String description) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new RuntimeException("Book not found"));
        book.setTitle(title);
        book.setAuthor(author);
        book.setGenre(genre);
        book.setDescription(description);
        bookRepository.save(book);
        return "redirect:/provider/manage";
    }




    @PostMapping("/{id}/{action}")
    public String handleRequestAction(Model model, HttpSession session, @PathVariable String action) {

        Long userId = (Long) session.getAttribute("userId");
        Provider provider = providerRepository.findById(userId).orElse(null);
        model.addAttribute("provider", provider);
        model.addAttribute("swapRequests", swapService.getSwapsByProvider(userId));

        Swap request = swapRepository.findById(userId).orElse(null);
        if (request != null) {
            if (action.equalsIgnoreCase("approve")) {
                request.setStatus("APPROVED");
            } else if (action.equalsIgnoreCase("deny")) {
                request.setStatus("DENIED");
            }
            swapRepository.save(request);
        }
        return "swaps";
    }


    @Controller
    @RequestMapping("/requests")
    public class SwapRequestController {

        @PostMapping("/{swapId}/approve")
        public String approveRequest(@PathVariable Long swapId) {
            swapService.approveSwap(swapId);
            return "redirect:/requests";
        }

        @PostMapping("/{swapId}/deny")
        public String denyRequest(@PathVariable Long swapId) {
            swapService.denySwap(swapId);
            return "redirect:/requests";
        }

        @GetMapping("/favicon.ico")
        @ResponseBody
        public void disableFavicon() {

        }


    }


    @GetMapping("/provider/messages")
    public String showProviderMessages(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/auth/login";
        }


        Provider provider = providerRepository.findById(userId).orElse(null);
        model.addAttribute("provider", provider);
        model.addAttribute("inbox", messageService.getMessagesByReceiver(userId));
        model.addAttribute("sent", messageService.getMessagesBySender(userId));

        return "provider-messages";
    }

    @PostMapping("/requests/{swapId}/accept")
    public String acceptSwap(@PathVariable Long swapId) {
        swapService.updateSwapStatus(swapId, "accepted");
        return "redirect:/requests";
    }

    // Provider replies to a message
    @PostMapping("/messages/reply")
    public String replyToCustomerMessage(@RequestParam Long receiverId,
                                         @RequestParam String content,
                                         HttpSession session) {
        Long senderId = (Long) session.getAttribute("userId");
        if (senderId == null) {
            return "redirect:/auth/login";
        }

        User sender = userRepository.findById(senderId)
                .orElseThrow(() -> new RuntimeException("Provider not found"));
        User receiver = userRepository.findById(receiverId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));


        Message message = new Message();
        message.setSender(sender);
        message.setReceiver(receiver);
        message.setContent(content);
        message.setCreatedAt(LocalDate.now());
        message.setStatus("unread");

        messageService.sendMessage(message);

        return "redirect:/provider/messages";
    }

    // Delete message
    @PostMapping("/provider/messages/delete/{messageId}")
    public String deleteMessage(@PathVariable Long messageId) {
        messageService.deleteMessageById(messageId);
        return "redirect:/provider/messages";
    }
}
