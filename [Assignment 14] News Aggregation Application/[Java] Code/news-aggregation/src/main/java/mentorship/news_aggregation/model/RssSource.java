package mentorship.news_aggregation.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "RssSource")
public class RssSource {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "website_url")
    private String websiteUrl;

    @OneToMany(mappedBy = "source")
    private List<Rss> rssFeeds;

    // Constructor
    public RssSource() {}

    public RssSource(String name, String websiteUrl) {
        this.name = name;
        this.websiteUrl = websiteUrl;
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

    public String getWebsiteUrl() {
        return websiteUrl;
    }

    public void setWebsiteUrl(String websiteUrl) {
        this.websiteUrl = websiteUrl;
    }

    public List<Rss> getRssFeeds() {
        return rssFeeds;
    }

    public void setRssFeeds(List<Rss> rssFeeds) {
        this.rssFeeds = rssFeeds;
    }
}
