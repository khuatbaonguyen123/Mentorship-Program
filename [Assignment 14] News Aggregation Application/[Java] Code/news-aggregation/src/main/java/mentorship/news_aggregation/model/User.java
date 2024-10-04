package mentorship.news_aggregation.model;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "User")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fullName;
    private String email;

    private String password;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<UserNewsInteraction> userNewsInteractions;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<UserTagInteraction> userTagInteractions;


    // Default constructor
    public User() {
    }

    // Parameterized constructor
    public User(String fullName, String email, String password) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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

    public List<UserNewsInteraction> getUserNewsInteractions() {
        return userNewsInteractions;
    }

    public void setUserNewsInteractions(List<UserNewsInteraction> userNewsInteractions) {
        this.userNewsInteractions = userNewsInteractions;
    }

    public List<UserTagInteraction> getUserTagInteractions() {
        return userTagInteractions;
    }

    public void setUserTagInteractions(List<UserTagInteraction> userTagInteractions) {
        this.userTagInteractions = userTagInteractions;
    }
}
