package mentorship.news_aggregation.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "User_News_Interaction")
public class UserNewsInteraction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "news_id")
    private News news;

    @Column(name = "type_interaction", columnDefinition = "enum('View')")
    private String typeInteraction;

    @Column(name = "created_at")
    private Date createdAt;

    // Constructor
    public UserNewsInteraction() {}

    public UserNewsInteraction(User user, News news, String typeInteraction) {
        this.user = user;
        this.news = news;
        this.typeInteraction = typeInteraction;
        this.createdAt = new Date();  // Initialize with the current date
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public News getNews() {
        return news;
    }

    public void setNews(News news) {
        this.news = news;
    }

    public String getTypeInteraction() {
        return typeInteraction;
    }

    public void setTypeInteraction(String typeInteraction) {
        this.typeInteraction = typeInteraction;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
