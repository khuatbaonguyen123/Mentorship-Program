package com.mentorship.news_aggregation.controller;

import com.mentorship.news_aggregation.service.RssService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/rss")
public class RssController {

    @Autowired
    private RssService rssService;

    @PostMapping("/load")
    public ResponseEntity<String> loadRssFeed(@RequestParam String rssUrl) {
        try {
            rssService.fetchAndSaveRssFeed(rssUrl);
            return ResponseEntity.ok("News items fetched and inserted successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error fetching news items: " + e.getMessage());
        }
    }
}
