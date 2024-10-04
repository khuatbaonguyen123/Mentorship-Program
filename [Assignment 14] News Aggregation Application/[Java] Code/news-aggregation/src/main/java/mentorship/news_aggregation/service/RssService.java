package mentorship.news_aggregation.service;

import mentorship.news_aggregation.model.News;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.InputStream;
import java.net.URL;
import java.sql.Timestamp;

@Service
public class RssService {

    @Autowired
    private NewsService newsService; // Service to handle news operations

    public String fetchAndParseRss(String rssUrl) {
        try {
            // Fetch the RSS feed
            Document doc = fetchRss(rssUrl);
            if (doc != null) {
                // Parse the RSS items
                parseRss(doc);
                return "RSS feed processed successfully!";
            } else {
                return "Error fetching RSS feed.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error processing RSS feed: " + e.getMessage();
        }
    }

    private Document fetchRss(String rssUrl) {
        try {
            URL url = new URL(rssUrl);
            InputStream inputStream = url.openStream();
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputStream);
            doc.getDocumentElement().normalize();
            return doc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private void parseRss(Document doc) {
        NodeList nodeList = doc.getElementsByTagName("item");
        for (int i = 0; i < nodeList.getLength(); i++) {
            String title = doc.getElementsByTagName("title").item(i).getTextContent();
            String description = doc.getElementsByTagName("description").item(i).getTextContent();
            String link = doc.getElementsByTagName("link").item(i).getTextContent();
            String guid = doc.getElementsByTagName("guid").item(i).getTextContent();
            String pubDate = doc.getElementsByTagName("pubDate").item(i).getTextContent();

            // Convert pubDate to Timestamp if necessary
            Timestamp publishedAt = Timestamp.valueOf(pubDate); // Adjust format if needed

            // Create and save the news item
            News news = new News();
            news.setTitle(title);
            news.setDescription(description);
            news.setLink(link);
            news.setGuid(guid);
            news.setPubDate(publishedAt);
            newsService.saveNews(news); // Service method to save the news item to the database
        }
    }
}


