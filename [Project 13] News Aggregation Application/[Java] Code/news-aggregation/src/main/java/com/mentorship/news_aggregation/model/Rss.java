package com.mentorship.news_aggregation.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "RSS")
public class Rss {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "link", nullable = false)
    private String link;

    @Column(name = "description")
    private String description;

    @Column(name = "language")
    private String language;

    @Column(name = "pub_date")
    private String pubDate;

    @ManyToOne
    @JoinColumn(name = "source_id", nullable = false)
    private RssSource rssSource;

    @OneToMany(mappedBy = "rss")
    private List<News> news;

    public Rss() {
        news = new ArrayList<>();
    }

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

    public String getPubDate() {
        return pubDate;
    }

    public void setPubDate(String pubDate) {
        this.pubDate = pubDate;
    }

    public RssSource getRssSource() {
        return rssSource;
    }

    public void setRssSource(RssSource rssSource) {
        this.rssSource = rssSource;
    }

    public List<News> getNews() {
        return news;
    }

    public void setNews(List<News> news) {
        this.news = news;
    }
}
