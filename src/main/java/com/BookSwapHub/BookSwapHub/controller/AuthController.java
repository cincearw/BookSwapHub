package com.BookSwapHub.BookSwapHub.controller;

import com.BookSwapHub.BookSwapHub.model.Provider;
import com.BookSwapHub.BookSwapHub.service.ProviderService;
import org.springframework.stereotype.Controller;
import com.BookSwapHub.BookSwapHub.repository.UserRepository;
import org.springframework.ui.Model;
import com.BookSwapHub.BookSwapHub.model.User;
import com.BookSwapHub.BookSwapHub.service.CustomerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.Optional;

@Controller
@RequestMapping("/auth")
@CrossOrigin
public class AuthController {

    @Autowired
    private CustomerService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProviderService providerService;


    //signup endpoint
    @GetMapping("/signup")
    public String showSignupPage() {
        return "signup";
    }

    @PostMapping("/signup")
    public String handleSignup(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String role,
            @RequestParam(required = false) String inviteCode,
            Model model) {

        if (userService.getUserByUsername(username).isPresent()) {
            model.addAttribute("error", "Username already taken.");
            return "signup";
        }

        if (role.equals("Provider")) {
            if (inviteCode == null || !inviteCode.equals("PROVIDER2025")) {
                model.addAttribute("error", "Invalid provider invite code.");
                return "signup";
            }

            Provider provider = new Provider();
            provider.setUsername(username);
            provider.setPassword(password);
            provider.setRole("Provider");
            provider.setName(name);
            provider.setEmail(email);

            userService.registerUser(provider);
            return "login";

        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole("Customer");
        user.setName(name);
        user.setEmail(email);

        userService.registerUser(user);
        return "redirect:/customer/dashboard?userId=" + user.getUserId();

    }


    @GetMapping("/login")
    public String showLoginForm() {
        return "login"; // login.ftlh
    }

    //simulate login by fetching user
    @GetMapping("/login/{username}")
    public String login(@PathVariable String username, HttpSession session) {
        Optional<User> userOpt = userService.getUserByUsername(username);
        //change to string if we want to redirect back from backend instead
        if (userOpt.isPresent()) {
            session.setAttribute("loggedInUser", userOpt.get());
            return "redirect: customer-dashboard.ftlh"; // landing on customer dashboard
        } else {
            return "redirect:/login?error=true";
        }
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            Model model,
                            HttpSession session) {

        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();

            if (user.getPassword().equals(password)) {
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("loggedInUser", user);

                if ("Customer".equalsIgnoreCase(user.getRole())) {
                    return "redirect:/customer/dashboard";
                } else if ("Provider".equalsIgnoreCase(user.getRole())) {

                    model.addAttribute("provider", user);
                    return "provider-dashboard";
                } else {
                    model.addAttribute("error", true);
                    return "login";
                }

            } else {
                model.addAttribute("error", "Incorrect password.");
                return "login";
            }
        } else {
            model.addAttribute("error", "No account found with that email.");
            return "login";
        }
    }
}