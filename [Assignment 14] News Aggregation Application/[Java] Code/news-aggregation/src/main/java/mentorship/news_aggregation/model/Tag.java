package mentorship.news_aggregation.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Tag")
public class Tag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", unique = true)
    private String name;

    @Column(name = "views_count")
    private Integer viewsCount;

    @Column(name = "saves_count")
    private Integer savesCount;

    @OneToMany(mappedBy = "tag")
    private List<News> news;

    @OneToMany(mappedBy = "tag")
    private List<UserTagInteraction> userInteractions;

    // Constructor
    public Tag() {}

    public Tag(String name) {
        this.name = name;
        this.viewsCount = 0;  // Default views count
        this.savesCount = 0;   // Default saves count
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getViewsCount() {
        return viewsCount;
    }

    public void setViewsCount(Integer viewsCount) {
        this.viewsCount = viewsCount;
    }

    public Integer getSavesCount() {
        return savesCount;
    }

    public void setSavesCount(Integer savesCount) {
        this.savesCount = savesCount;
    }

    public List<News> getNews() {
        return news;
    }

    public void setNews(List<News> news) {
        this.news = news;
    }

    public List<UserTagInteraction> getUserInteractions() {
        return userInteractions;
    }

    public void setUserInteractions(List<UserTagInteraction> userInteractions) {
        this.userInteractions = userInteractions;
    }
}
