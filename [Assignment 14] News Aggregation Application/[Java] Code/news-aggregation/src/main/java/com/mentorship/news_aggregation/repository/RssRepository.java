package com.mentorship.news_aggregation.repository;

import com.mentorship.news_aggregation.model.Rss;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RssRepository extends JpaRepository<Rss, Long> {
}
