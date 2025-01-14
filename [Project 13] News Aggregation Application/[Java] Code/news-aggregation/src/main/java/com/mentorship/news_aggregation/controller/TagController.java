package com.mentorship.news_aggregation.controller;

import com.mentorship.news_aggregation.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/tag")
public class TagController {
    @Autowired
    private TagService tagService;

    @PostMapping("/scrape")
    public ResponseEntity<String> scrapeTagFromNews(@RequestParam String newsUrl) {
        try {
            tagService.scrapeTagsFromNewsLink(newsUrl);
            return ResponseEntity.ok("Tags scraped and inserted successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error scraping tags: " + e.getMessage());
        }
    }
}
