package mentorship.news_aggregation.model;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "RSS")
public class Rss {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "title")
    private String title;

    @Column(name = "link")
    private String link;

    @Column(name = "description")
    private String description;

    @Column(name = "language")
    private String language;

    @Column(name = "pub_date")
    private Date pubDate;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_at")
    private Date updatedAt;

    @Column(name = "extra_fields", columnDefinition = "json")
    private String extraFields;  // Store JSON as a String

    @ManyToOne
    @JoinColumn(name = "source_id", referencedColumnName = "id")
    private RssSource source;

    @OneToMany(mappedBy = "rss_id")
    private List<News> newsItems;

    // Constructor
    public Rss() {}

    public Rss(String title, String link, String description, String language, String extraFields, RssSource source) {
        this.title = title;
        this.link = link;
        this.description = description;
        this.language = language;
        this.extraFields = extraFields;  // Set the JSON string
        this.source = source;
        this.createdAt = new Date();  // Initialize with the current date
        this.updatedAt = new Date();  // Initialize with the current date
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public Date getPubDate() {
        return pubDate;
    }

    public void setPubDate(Date pubDate) {
        this.pubDate = pubDate;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getExtraFields() {
        return extraFields;
    }

    public void setExtraFields(String extraFields) {
        this.extraFields = extraFields;
    }

    public RssSource getSource() {
        return source;
    }

    public void setSource(RssSource source) {
        this.source = source;
    }

    public List<News> getNewsItems() {
        return newsItems;
    }

    public void setNewsItems(List<News> newsItems) {
        this.newsItems = newsItems;
    }
}
