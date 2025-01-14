package com.mentorship.news_aggregation.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "Tag")
public class Tag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, unique = true)
    private String name;

    @Column(name = "views_count", nullable = false)
    private int viewsCount;

    @Column(name = "saves_count", nullable = false)
    private int savesCount;

    @OneToMany(mappedBy = "tag")
    private List<NewsTag> newsTags;

    // Default constructor
    public Tag() {
        newsTags = new ArrayList<>();
        viewsCount = 0;
        savesCount = 0;
    }

    public Tag(String name) {
        this.name = name;
        newsTags = new ArrayList<>();
        viewsCount = 0;
        savesCount = 0;
    }

    // Getters and setters
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

    public int getViewsCount() {
        return viewsCount;
    }

    public void setViewsCount(int viewsCount) {
        this.viewsCount = viewsCount;
    }

    public int getSavesCount() {
        return savesCount;
    }

    public void setSavesCount(int savesCount) {
        this.savesCount = savesCount;
    }

    public List<NewsTag> getNewsTags() {
        return newsTags;
    }

    public void setNewsTags(List<NewsTag> newsTags) {
        this.newsTags = newsTags;
    }
}
