package mentorship.news_aggregation.controller;

import mentorship.news_aggregation.service.RssService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/rss")
public class RssController {

    @Autowired
    private RssService rssService; // Service for handling RSS operations

    @PostMapping("/fetch")
    public String fetchRss(@RequestBody String rssUrl) {
        // Call the service method to fetch and parse the RSS feed
        return rssService.fetchAndParseRss(rssUrl);
    }
}

