package com.mentorship.news_aggregation.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class RssSourceService {

    public List<String> getRssLinksFromUrl(String url) throws IOException {
        List<String> rssLinks = new ArrayList<>();

        // Fetch the HTML from the URL
        Document doc = Jsoup.connect(url).get();

        // Look for 'link' tags that have rel='alternate' and type='application/rss+xml'
        Elements rssElements = doc.select("link[type=application/rss+xml]");

        // Extract the href attribute of each RSS link
        for (Element element : rssElements) {
            String rssLink = element.attr("href");
            rssLinks.add(rssLink);
        }

        return rssLinks;
    }
}
