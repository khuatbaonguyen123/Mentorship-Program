package com.mentorship.news_aggregation.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "News")
public class News {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "description", nullable = true)
    private String description;

    @Column(name = "link", nullable = false)
    private String link;

    @Column(name = "guid", nullable = true)
    private String guid;

    @Column(name = "views_count", nullable = true)
    private Integer viewsCount;

    @ManyToOne
    @JoinColumn(name = "rss_id")
    private Rss rss;

    @OneToMany(mappedBy = "news")
    private List<NewsTag> newsTags;

    public News() {
        newsTags = new ArrayList<>();
        viewsCount = 0;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public Integer getViewsCount() {
        return viewsCount;
    }

    public void setViewsCount(Integer viewsCount) {
        this.viewsCount = viewsCount;
    }

    public Rss getRss() {
        return rss;
    }

    public void setRss(Rss rss) {
        this.rss = rss;
    }

    public List<NewsTag> getNewsTags() {
        return newsTags;
    }

    public void setNewsTags(List<NewsTag> newsTags) {
        this.newsTags = newsTags;
    }
}
