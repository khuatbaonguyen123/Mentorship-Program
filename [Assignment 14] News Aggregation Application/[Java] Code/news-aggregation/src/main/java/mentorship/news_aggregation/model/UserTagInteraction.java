package mentorship.news_aggregation.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "UserTagInteraction")
public class UserTagInteraction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "tag_id", referencedColumnName = "id")
    private Tag tag;

    @Column(name = "interaction_type", columnDefinition = "enum('View', 'Save')")
    private String interactionType;

    @Column(name = "created_at")
    private Date createdAt;

    // Constructor
    public UserTagInteraction() {}

    public UserTagInteraction(User user, Tag tag, String interactionType) {
        this.user = user;
        this.tag = tag;
        this.interactionType = interactionType;
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

    public Tag getTag() {
        return tag;
    }

    public void setTag(Tag tag) {
        this.tag = tag;
    }

    public String getInteractionType() {
        return interactionType;
    }

    public void setInteractionType(String interactionType) {
        this.interactionType = interactionType;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
