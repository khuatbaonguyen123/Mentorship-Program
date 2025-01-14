package com.mentorship.news_aggregation.controller;

import com.mentorship.news_aggregation.dto.SignInDto;
import com.mentorship.news_aggregation.dto.SignUpDto;
import com.mentorship.news_aggregation.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    // Sign-up API
    @PostMapping("/signup")
    public ResponseEntity<String> signUp(@RequestBody SignUpDto signUpDto) {
        try {
            userService.signUp(signUpDto);
            return ResponseEntity.ok("User registered successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // Sign-in API
    @PostMapping("/signin")
    public ResponseEntity<String> signIn(@RequestBody SignInDto signInDto) {
        try {
            userService.signIn(signInDto.getEmail(), signInDto.getPassword());
            return ResponseEntity.ok("Sign in successful");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}

