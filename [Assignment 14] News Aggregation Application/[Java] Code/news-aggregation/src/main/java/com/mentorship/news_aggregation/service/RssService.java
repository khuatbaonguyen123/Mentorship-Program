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
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.regex.Pattern;

@Service
public class RssService {
    @Autowired
    private NewsRepository newsRepository; // Inject your News repository

    // A regex pattern that checks for typical RSS-related keywords in the URL
    private static final Pattern RSS_PATTERN = Pattern.compile(".*(rss|feed|xml|atom).*", Pattern.CASE_INSENSITIVE);

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

    public static boolean isRssLink(String urlString, SyndFeedInput input) {
        // First check the URL pattern
        if (!RSS_PATTERN.matcher(urlString).find()) {
            return false;
        }

        HttpURLConnection connection = null;

        try {
            URL url = new URL(urlString);

            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(10000); // Set a timeout for the connection
            connection.setReadTimeout(10000);

            SyndFeed syndFeed = input.build(new XmlReader(url));

            return true;
        } catch (Exception e) {
            if (connection != null) {
                connection.disconnect(); // Ensure the connection is closed
            }
        }

        return false; // Not a valid RSS feed
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
