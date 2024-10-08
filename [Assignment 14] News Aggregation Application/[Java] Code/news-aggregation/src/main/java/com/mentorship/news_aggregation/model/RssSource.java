package com.mentorship.news_aggregation.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "rss_source")
public class RssSource {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(name = "website_url", nullable = false)
    private String websiteUrl;

    @OneToMany(mappedBy = "rssSource", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Rss> rssFeeds = new ArrayList<>();

    public RssSource() {}

    public RssSource(String name, String websiteUrl) {
        this.name = name;
        this.websiteUrl = websiteUrl;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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
