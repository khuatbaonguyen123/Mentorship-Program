package com.mentorship.news_aggregation.service;

import com.mentorship.news_aggregation.model.Rss;
import com.rometools.rome.io.SyndFeedInput;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class RssSourceService {

    SyndFeedInput syndFeedInput = new SyndFeedInput();

    public List<String> getRssLinksFromUrl(String url) throws IOException {
        List<String> rssLinks = new ArrayList<>();

        Document doc = Jsoup.connect(url)
                .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36")
                .header("Accept-Language", "*")
                .get();

        Elements rssElements = doc.getElementsByTag("a");

        for (Element element : rssElements) {
            String rssLink = element.absUrl("href");
            if(RssService.isRssLink(rssLink, syndFeedInput)) {
                rssLinks.add(rssLink);
            }
        }

        return rssLinks;
    }
}
