package com.mentorship.news_aggregation.service;

import com.mentorship.news_aggregation.model.News;
import com.mentorship.news_aggregation.repository.NewsRepository;
import com.rometools.rome.feed.synd.SyndEntry;
import com.rometools.rome.feed.synd.SyndFeed;
import com.rometools.rome.io.FeedException;
import com.rometools.rome.io.SyndFeedInput;
import com.rometools.rome.io.XmlReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URL;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class RssService {
    @Autowired
    private NewsRepository newsRepository; // Inject your News repository

    public void fetchAndSaveRssFeed(String rssUrl) {
        try {
            // Lấy feed từ RSS URL
            SyndFeed feed = getFeedFromUrl(rssUrl);
            
            // Xử lý danh sách bài viết từ RSS feed
            List<SyndEntry> entries = feed.getEntries();

            for (SyndEntry entry : entries) {
                News news = new News();
                news.setTitle(entry.getTitle());
                news.setDescription(entry.getDescription().getValue());
                news.setLink(entry.getLink());

                newsRepository.save(news); // Save news item to the database
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error when trying to save news item from " + rssUrl);
        }
    }

    public static boolean isRSSLink(String urlString) {
        try {
            // Create a URL object
            URL url = new URL(urlString);

            // Use ROME to parse the feed
            SyndFeedInput input = new SyndFeedInput();
            SyndFeed feed = input.build(new XmlReader(url));

            // If feed parsing is successful, it is an RSS or Atom feed
            return true;

        } catch (IllegalArgumentException | FeedException | IOException e) {
            // If an exception is thrown, it is not a valid RSS/Atom feed
            return false;
        }
    }

    // Phương thức lấy RSS feed từ URL
    private SyndFeed getFeedFromUrl(String rssUrl) {
        try {
            URL url = new URL(rssUrl);
            SyndFeedInput input = new SyndFeedInput();
            return input.build(new XmlReader(url));
        } catch (FeedException | IOException e) {
            throw new RuntimeException("Lỗi khi đọc RSS feed từ URL: " + rssUrl, e);
        }
    }
}
