package com.mentorship.news_aggregation.service;

import com.mentorship.news_aggregation.dto.SignUpDto;
import com.mentorship.news_aggregation.model.User;
import com.mentorship.news_aggregation.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Sign-up logic
    public void signUp(SignUpDto userDto) throws Exception {
        if (userRepository.findByEmail(userDto.getEmail()).isPresent()) {
            throw new Exception("Email already registered");
        }

        User user = new User();

        user.setFullName(userDto.getFullName());
        user.setEmail(userDto.getEmail());
        user.setPassword(BCrypt.hashpw(userDto.getPassword(), BCrypt.gensalt())); // Encrypt the password

        userRepository.save(user);
    }

    // Sign-in logic
    public User signIn(String email, String password) throws Exception {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new Exception("Invalid email or password"));

        if (!BCrypt.checkpw(password, user.getPassword())) {
            throw new Exception("Invalid email or password");
        }

        return user;
    }
}

