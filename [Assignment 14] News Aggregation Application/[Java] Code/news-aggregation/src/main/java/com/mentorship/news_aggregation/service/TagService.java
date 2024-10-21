package com.mentorship.news_aggregation.service;

import com.mentorship.news_aggregation.model.Tag;
import com.mentorship.news_aggregation.repository.TagRepository;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TagService {

    @Autowired
    private TagRepository tagRepository;

    public void scrapeTagsFromNewsLink(String newsUrl) throws IOException {
        // Fetch the HTML from the news link
        Document doc = Jsoup.connect(newsUrl)
                .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36")
                .header("Accept-Language", "*")
                .get();

        // Find the div containing tags
        Element detailTabDiv = doc.selectFirst("div.detail-tab");

        if (detailTabDiv != null) {
            // Select all <a> tags within this div
            Elements tagElements = detailTabDiv.getElementsByTag("a");

            // Extract the title attribute as the tag name
            for (Element tagElement : tagElements) {
                String tagName = tagElement.attr("title");

                // Check if the tag already exists in the database
                Optional<Tag> existingTag = tagRepository.findByName(tagName);
                if (existingTag.isEmpty()) {
                    Tag tag = new Tag(tagName);
                    tagRepository.save(tag);
                }
            }
        }
    }
}
