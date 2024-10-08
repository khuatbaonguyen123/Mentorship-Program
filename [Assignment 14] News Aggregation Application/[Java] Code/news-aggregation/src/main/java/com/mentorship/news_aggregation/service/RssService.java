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
