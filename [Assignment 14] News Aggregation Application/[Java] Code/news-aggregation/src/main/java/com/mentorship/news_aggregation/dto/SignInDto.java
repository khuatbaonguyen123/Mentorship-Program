package com.mentorship.news_aggregation.dto;

public class SignInDto {
    private String email;
    private String password;

    public SignInDto() {

    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
