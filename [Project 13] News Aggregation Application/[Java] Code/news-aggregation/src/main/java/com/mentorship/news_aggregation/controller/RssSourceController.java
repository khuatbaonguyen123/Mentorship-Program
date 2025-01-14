package com.mentorship.news_aggregation.controller;

import com.mentorship.news_aggregation.service.RssSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/rss-source")
public class RssSourceController {

    @Autowired
    private RssSourceService rssSourceService;

    // POST API to scrape RSS XML links from the provided website URL
    @GetMapping("/scrape")
    public List<String> scrapeRssLinks(@RequestParam String websiteUrl) throws IOException {
        return rssSourceService.getRssLinksFromUrl(websiteUrl);
    }
}
